#!/bin/bash
# shellcheck shell=bash

PID1=false
if [ "$$" -eq 1 ]; then
    PID1=true
    echo "Starting as entrypoint"
    if [ -d /command ]; then
        ln -sf /command/* /usr/bin/ 2> /dev/null || true
    fi
else
    echo "Starting custom scripts"
fi

pick_exec_dir() {
    local d
    for d in /dev/shm /run /var/run /mnt /root /; do
        if [ -d "$d" ] && [ -w "$d" ]; then
            local t="${d%/}/.exec_test_$$"
            printf '#!/bin/sh\necho ok\n' > "$t" 2> /dev/null || {
                rm -f "$t" 2> /dev/null || true
                continue
            }
            chmod 700 "$t" 2> /dev/null || {
                rm -f "$t" 2> /dev/null || true
                continue
            }
            if "$t" > /dev/null 2>&1; then
                rm -f "$t" 2> /dev/null || true
                echo "$d"
                return 0
            fi
            rm -f "$t" 2> /dev/null || true
        fi
    done
    return 1
}

EXEC_DIR="$(pick_exec_dir || true)"
if [ -z "${EXEC_DIR:-}" ]; then
    echo "ERROR: Could not find an exec-capable writable directory."
    exit 1
fi

candidate_shebangs=(
    "/command/with-contenv bashio"
    "/usr/bin/with-contenv bashio"
    "/usr/bin/env bashio"
    "/usr/bin/bashio"
    "/usr/bin/bash"
    "/bin/bash"
    "/usr/bin/sh"
    "/bin/sh"
)

SHEBANG_ERRORS=()

probe_script_content='
set -e

if ! command -v bashio::addon.version >/dev/null 2>&1; then
  for f in \
    /usr/lib/bashio/bashio.sh \
    /usr/lib/bashio/lib.sh \
    /usr/src/bashio/bashio.sh \
    /usr/local/lib/bashio/bashio.sh
  do
    if [ -f "$f" ]; then
      . "$f"
      break
    fi
  done
fi

set +e
_bv="$(bashio::addon.version 2>/dev/null)"
_rc=$?
set -e

if [ "$_rc" -ne 0 ] || [ -z "$_bv" ] || [ "$_bv" = "null" ]; then
  for _sf in /usr/local/lib/bashio-standalone.sh /.bashio-standalone.sh; do
    if [ -f "$_sf" ]; then
      . "$_sf"
      _bv="$(bashio::addon.version 2>/dev/null || true)"
      break
    fi
  done
fi

echo "${_bv:-PROBE_OK}"
'

validate_shebang() {
    local candidate="$1"
    local tmp out rc errfile msg
    local cmd=($candidate)
    local exe="${cmd[0]}"
    if [ ! -x "$exe" ]; then
        SHEBANG_ERRORS+=(" - FAIL (not executable): #!$candidate")
        return 1
    fi
    tmp="${EXEC_DIR%/}/shebang_test.$$.$RANDOM"
    errfile="${EXEC_DIR%/}/shebang_probe_err.$$"
    {
        printf '#!%s\n' "$candidate"
        printf '%s\n' "$probe_script_content"
    } > "$tmp"
    chmod 700 "$tmp" 2> /dev/null || true
    set +e
    out="$("$tmp" 2> "$errfile")"
    rc=$?
    set -e
    rm -f "$tmp" 2> /dev/null || true
    if [ "$rc" -eq 0 ] && [ -n "${out:-}" ] && [ "$out" != "null" ]; then
        rm -f "$errfile" 2> /dev/null || true
        return 0
    fi
    msg=$' - FAIL: #!'"$candidate"$'\n'"   rc=$rc, stdout='${out:-}'"
    if [ -s "$errfile" ]; then
        msg+=$'\n   stderr:\n'
        msg+="$(sed -n '1,8p' "$errfile")"
    fi
    SHEBANG_ERRORS+=("$msg")
    rm -f "$errfile" 2> /dev/null || true
    return 1
}

shebang=""
for candidate in "${candidate_shebangs[@]}"; do
    if validate_shebang "$candidate"; then
        shebang="$candidate"
        break
    fi
done

if [ -z "$shebang" ]; then
    echo "ERROR: No valid shebang found." >&2
    exit 1
fi

BASHIO_LIB=""
for f in /usr/lib/bashio/bashio.sh /usr/lib/bashio/lib.sh /usr/src/bashio/bashio.sh /usr/local/lib/bashio/bashio.sh; do
    if [ -f "$f" ]; then
        BASHIO_LIB="$f"
        break
    fi
done
if [ -z "$BASHIO_LIB" ]; then
    for f in /usr/local/lib/bashio-standalone.sh /.bashio-standalone.sh; do
        if [ -f "$f" ]; then
            BASHIO_LIB="$f"
            break
        fi
    done
fi

run_one_script() {
    local script="$1"
    echo "$script: executing"
    if [ "$(id -u)" -eq 0 ]; then
        chown "$(id -u)":"$(id -g)" "$script" || true
        chmod a+x "$script" || true
    else
        sed -i "s/^[[:space:]]*chown /true # chown /g" "$script"
        sed -i "s/^[[:space:]]*chmod /true # chmod /g" "$script"
    fi
    sed -i "1s|^.*|#!$shebang|" "$script"
    chmod +x "$script"
    if [ "${ha_entry_source:-null}" = "true" ]; then
        sed -i -E 's/^[[:space:]]*exit ([0-9]+)/return \1 \|\| exit \1/g' "$script"
        sed -i 's/bashio::exit\.nok/return 1/g' "$script"
        sed -i 's/bashio::exit\.ok/return 0/g' "$script"
        source "$script" || echo -e "\033[0;31mError\033[0m : $script exiting $?"
    else
        _run_rc=0
        "$script" || _run_rc=$?
        if [ "$_run_rc" -eq 126 ] && [ -n "${BASHIO_LIB:-}" ]; then
            echo "Direct exec failed (rc=126), retrying via source..."
            _run_rc=0
            (
                . "$BASHIO_LIB" 2> /dev/null || true
                . "$script"
            ) || _run_rc=$?
            if [ "$_run_rc" -ne 0 ]; then
                echo -e "\033[0;31mError\033[0m : $script exiting $_run_rc"
            fi
        elif [ "$_run_rc" -ne 0 ]; then
            echo -e "\033[0;31mError\033[0m : $script exiting $_run_rc"
        fi
    fi
    sed -i '1a exit 0' "$script"
}

if [ -d /etc/cont-init.d ]; then
    for SCRIPTS in /etc/cont-init.d/*; do
        [ -e "$SCRIPTS" ] || continue
        run_one_script "$SCRIPTS"
    done
fi

if $PID1; then
    shopt -s nullglob
    for runfile in /etc/services.d/*/run /etc/s6-overlay/s6-rc.d/*/run; do
        [ -f "$runfile" ] || continue
        echo "Starting: $runfile"
        sed -i "1s|^.*|#!$shebang|" "$runfile"
        chmod +x "$runfile"
        (
            restart_count=0
            max_restarts=5
            while true; do
                _svc_rc=0
                "$runfile" || _svc_rc=$?
                if [ "$_svc_rc" -eq 126 ] && [ -n "${BASHIO_LIB:-}" ]; then
                    _svc_rc=0
                    (
                        . "$BASHIO_LIB" 2> /dev/null || true
                        . "$runfile"
                    ) || _svc_rc=$?
                fi
                rc=$_svc_rc
                if [ "$rc" -eq 0 ]; then
                    echo "$runfile exited cleanly, not restarting."
                    break
                fi
                restart_count=$((restart_count + 1))
                if [ "$restart_count" -ge "$max_restarts" ]; then
                    echo -e "\033[0;31mERROR: $runfile crashed $restart_count times, giving up.\033[0m"
                    break
                fi
                echo -e "\e[38;5;214m$(date) WARNING: $runfile exited ($rc), restarting (#${restart_count}) in 5s...\e[0m"
                sleep 5
            done
        ) &
    done
    shopt -u nullglob
fi

if $PID1; then
    echo " "
    echo -e "\033[0;32mEverything started!\033[0m"
    terminate() {
        echo "Termination signal received..."
        if command -v pgrep > /dev/null 2>&1; then
            while read -r pid; do
                [ -n "$pid" ] || continue
                kill -TERM "$pid" 2> /dev/null || true
            done < <(pgrep -P "$$" || true)
        fi
        wait || true
        exit 0
    }
    trap terminate SIGTERM SIGINT
    while :; do
        sleep infinity &
        wait $!
    done
else
    echo " "
    echo -e "\033[0;32mStarting the upstream container\033[0m"
    echo " "
fi
