<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 1.18.31 (2026-09-15)

Updated to upstream OpenCode **1.18.31**:

### Core

### Bugfixes

- Restored ACP session model, effort, mode, and reasoning chunk boundaries when loading, resuming, or forking sessions. (@JacobNWolf)

### TUI

### Bugfixes

- Show remote config authentication errors during startup and exit with a failure status.

### Extensions

### Improvements

- Request summarized adaptive thinking for GitHub Copilot models.

**Thank you to 4 community contributors:**
- @heimoshuiyu:
  - feat(console): add batch workspace block endpoints (#48491)
- @JacobNWolf:
  - fix(acp): restore session options and reasoning boundaries (#48225)
- @R-Taneja:
  - chore(deps): bump @ai-sdk/gateway to 3.0.191 (#48710)
- @MatthewFeroz:
  - fix(ui): add Merge Gateway logo (#42015)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.31)

## 1.18.30 (2026-09-09)

Updated to upstream OpenCode **1.18.30**:

### Core
### Improvements
- Added the Astra system prompt for GPT-6 models.

### Bugfixes
- Preserved Bedrock DeepSeek model IDs, including ARN-based IDs, so they resolve correctly. (@YeEmrick)
- Updated the Azure provider SDK to pick up compatibility fixes.
- Updated the OpenAI provider SDK to pick up compatibility fixes.
- Added reasoning effort variants for supported GitLab GPT and Claude models. (@far-ouq)

**Thank you to 3 community contributors:**
- @heimoshuiyu:
  - fix(console): openai usage normalization and tier threshold config (#47342)
- @far-ouq:
  - fix(opencode): add GitLab reasoning variants (#47306)
- @YeEmrick:
  - fix: preserve Bedrock DeepSeek model ids (#34441)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.30)

## 1.18.29 (2026-09-05)

Updated to upstream OpenCode **1.18.29**:

### Core

### Bugfixes

- Allow Codex OAuth model filtering to recognize integer GPT versions like `gpt-6`
- Fixes issue of gpt-6-astra not showing up for openai subscription users

**Thank you to 2 community contributors:**
- @Peter267:
  - docs(zh): fix bold rendering by adding spaces around asterisks (#46231)
- @heimoshuiyu:
  - feat(console): add quota reset support action (#47313)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.29)

## 1.18.27 (2026-09-03)

Updated to upstream OpenCode **1.18.27**:

### Core

### Bugfixes

- Default provider header timeouts to five minutes so slow model startups fail less often.
- Default streamed chunk timeouts to five minutes, with `false` supported to disable them.
- Let Anthropic `thinking.blockBinding` opt out via config when you need to keep the provider default. (@dkindlund)
- Limit Anthropic thinking block binding to Claude 5.1+ models so older deployments do not reject requests.
- Avoid unhandled errors when canceling timed-out SSE reads. (@AlexanderWillner)

**Thank you to 2 community contributors:**
- @AlexanderWillner:
  - fix(provider): handle SSE reader cancel rejections (#44944)
- @dkindlund:
  - fix(opencode): let config opt out of Anthropic thinking blockBinding (#46820)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.27)

## 1.18.26 (2026-09-02)

Updated to upstream OpenCode **1.18.26**:

### Core

### Bugfixes

- Claude 5 sessions now tolerate stale thinking blocks instead of failing after prompt or tool changes.
- Bedrock GPT-5.6 models now accept `none` reasoning effort.
- Bedrock reasoning and replay handling is more reliable. (@pengzh1)
- Tool call timing now stays accurate when tools update their metadata while still running. (@bartlettroscoe)
- `apply_patch` no longer emits an empty move path in permission metadata. (@altendky)

### Improvements

- Azure CLI sign-in now asks for the resource name directly instead of querying Azure management APIs.

### Desktop

### Bugfixes

- Session renames now save reliably from the title editor and tab context menu.

**Thank you to 3 community contributors:**
- @altendky:
  - fix(opencode): omit empty apply patch move path (#45329)
- @pengzh1:
  - fix(core): bump @ai-sdk/amazon-bedrock to 4.0.166 for reasoning and replay fixes (#45520)
- @bartlettroscoe:
  - fix(core): Fix for incorrect time.start reset in tool call logging (#32574) (#32596)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.26)

## 1.18.25 (2026-08-28)

Updated to upstream OpenCode **1.18.25**:

### Core
### Bugfixes
- Fixed Azure authentication so Azure CLI sign-in works without requiring Bun.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.25)

## 1.18.23 (2026-08-26)

Updated to upstream OpenCode **1.18.23**:

### Core

### Bugfixes

- Fixed Cloudflare AI Gateway routing for third-party providers so non-Workers models work through the gateway's REST API. (@superhighfives)
- Fixed Anthropic models through Cloudflare AI Gateway by converting dotted model IDs like `claude-haiku-4.5` to the dashed slug Anthropic expects. (@superhighfives)
- Fixed parent session IDs being sent in request headers for session-aware providers.

### TUI

### Bugfixes

- Fixed GitHub auth for immutable OIDC subject tokens.

**Thank you to 1 community contributor:**
- @superhighfives:
  - fix(provider): send Anthropic's dashed native slug through the AI Gateway (#44281)
  - fix(provider): route non-native Cloudflare AI Gateway providers via the REST API (#44828)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.23)

## 1.18.22 (2026-08-25)

Updated to upstream OpenCode **1.18.22**:

### Core

### Bugfixes

- Removed outdated OpenCode Go first-month discount messaging and pricing.
- Fixed OpenCode device login links when servers return relative verification URLs or use a base path.
- Fixed `textVerbosity` being sent to OpenAI-compatible providers that do not support it. (@joelstucki-taulia)
- Updated the Amazon Bedrock provider for compatibility fixes.

### Desktop

### Bugfixes

- Keep model provider headers visible while scrolling the model picker.

**Thank you to 1 community contributor:**
- @joelstucki-taulia:
  - fix(provider): guard textVerbosity injection for @ai-sdk/openai-compatible providers (#43915)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.22)

## 1.18.21 (2026-08-22)

Updated to upstream OpenCode **1.18.21**:

### Core

### Bugfixes

- Continue responses when a model reports an unknown finish reason instead of stopping early
- Route Vertex AI `eu` and `us` multi-region Gemini requests through REP endpoints

### Desktop

### Bugfixes

- Keep file search results visible while the next search is loading
- Register the archive session command in both desktop layouts (@NathanTCode)

**Thank you to 1 community contributor:**
- @NathanTCode:
  - fix(app): register archive session command in both layouts (#41741)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.21)

## 1.18.19 (2026-08-21)

Updated to upstream OpenCode **1.18.19**:

### Core

### Improvements

- Added native OpenAI and Anthropic passthroughs for Cloudflare AI Gateway models.
- Matched Codex rate limits more closely to ChatGPT subscription limits. (@GameOn223)

### Bugfixes

- Removed built-in Qwen sampling defaults that could send unsupported settings.
- Properly show authenticated providers in `/connect`. (@OpeOginni)
- Ignore malformed model pricing instead of breaking usage cost calculation.
- Fall back when OpenAI websocket requests exceed message size limits.
- Forward ChatGPT workspace compute residency to Codex requests.
- Updated the default Console URL used by account connection flows.
- Enabled web search when using the OpenCode Go provider.
- Preserved compatibility with existing v1 databases.

### Desktop

### Bugfixes

- Kept saved server details editable in the server dialog.

**Thank you to 4 community contributors:**
- @TechyAditya:
  - fix(skills): Update global config path in documentation (#42337)
- @GameOn223:
  - tweak: match codex limits for openai models exactly when using chatgpt subscription (#39082)
- @OpeOginni:
  - fix(opencode): properly show authed providers on /connect command (#39915)
- @bhuvan2134686:
  - docs: add SCX.ai to the providers list (#42520)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.19)

## 1.18.18 (2026-08-13)

Updated to upstream OpenCode **1.18.18**:

### Core
### Bugfixes
- Select the Kimi system prompt correctly for official Moonshot and Kimi providers
- Fix xhigh reasoning effort for xai models

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.18)

## 1.18.16 (2026-08-11)

Updated to upstream OpenCode **1.18.16**:

### Core

### Bugfixes

- Ignore unknown top-level config fields instead of failing config parsing
- Register projects opened from Home so they are available to the rest of the app

### Desktop

### Improvements

- Open the project menu with a right-click in Home

### Bugfixes

- Fall back to listing and matching local directories when the project picker server does not support search
- Use 词元 instead of 令牌 for token-related labels in Simplified Chinese (@Speechlessmanbilibili)
- Keep the macOS app running after the last window closes and reopen a window when the app is activated

**Thank you to 1 community contributor:**
- @Speechlessmanbilibili:
  - fix(i18n): use 词元 instead of 令牌 for token in zh locale (#40977)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.16)

## 1.18.15 (2026-08-08)

Updated to upstream OpenCode **1.18.15**:

### Core

### Bugfixes

- Chronological message ordering now stays correct even when imported or legacy message IDs are out of order.
- Revert and fork actions now use real message chronology instead of message ID ordering.
- Truncation cleanup now removes stale files by file timestamp more reliably.
- Repeated compaction now keeps earlier tool-call history in summaries instead of dropping orphaned results.
- Blob-based attachments now load correctly in the web UI. (@rexdotsh)

### Desktop

### Improvements

- Added much broader locale coverage across the desktop app.
- Export full session transcripts as JSON from the UI.

### Bugfixes

- Session timelines now respect chronological message boundaries more reliably.
- Stored messages now stay ordered by creation time.
- Session lists now sort by persisted activity time more reliably.
- Language names now stay native in the locale picker.
- Filled in missing translations across existing locales.

**Thank you to 3 community contributors:**
- @rexdotsh:
  - fix(server): allow blob attachments in web UI (#40692)
- @ayubun:
  - fix(tui): support copying over ssh with `set-clipboard on` tmux config (#30472)
- @dangooddd:
  - feat(tui): add cursor style configuration (#32295)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.15)

## 1.18.14 (2026-08-06)

Updated to upstream OpenCode **1.18.14**:

### Core

### Improvements

- Simplified xAI login to a single device-code flow that works better in headless and remote environments.

### Bugfixes

- Preserved structured mid-stream provider errors so compatible providers can retry failed responses.
- Retried more transient provider and network errors instead of failing immediately.
- Counted cache writes in ACP usage totals.
- Logged remote workspace 5xx response bodies in the host logs to make proxy failures easier to debug. (@jamesmurdza)
- Stopped sending the host `directory` path to remote workspaces so prompts resolve from the remote project root. (@jamesmurdza)
- Waited for queued ACP session updates before ending a turn.

**Thank you to 1 community contributor:**
- @jamesmurdza:
  - fix(server): don't forward host directory to remote workspace (#40136)
  - fix(server): log upstream 5xx bodies from proxied workspace requests (#40135)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.14)

## 1.18.13 (2026-08-05)

Updated to upstream OpenCode **1.18.13**:

### TUI
### Bugfixes
- GitHub pull request reviews now include the pull request number and URL in context.

### Desktop
### Bugfixes
- Fixed several right-to-left layout issues across tabs, drawers, resizing, and titlebar interactions.
- Fixed shared right-to-left UI behavior such as directional icons and drawer placement.
- Sessions without titles now fall back to generated names instead of appearing blank.
- Moved markdown parsing off the main thread to keep the app more responsive while rendering messages.

### Improvements
- Localized more desktop UI copy, including native menus, update dialogs, and help content.
- Added early right-to-left layout support across the app and session views.
- Added locale-aware plural rules so translated counts and summaries read correctly.
- Expanded translation coverage and added more supported desktop languages.

**Thank you to 1 community contributor:**
- @amypoolside:
  - docs: add Poolside provider setup (#39187)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.13)

## 1.18.12 (2026-08-04)

Updated to upstream OpenCode **1.18.12**:

### Core
### Bugfixes
- Fixed Azure GPT-5.5+ completion requests failing when reasoning is enabled. (@frederiknsgo)

### Desktop
### Bugfixes
- Reduced composer lag when drafts include large pasted images or attachments.
- Let project search match any known recent project instead of only the first five. (@NumerousJLs)
- Cleared stale assistant errors from the timeline once the same turn resumes streaming.
- Skipped legacy config reads against v2 servers to avoid spurious config loading issues. (@resetsix)

**Thank you to 4 community contributors:**
- @resetsix:
  - fix(app): skip legacy config reads for v2 (#40211)
- @NumerousJLs:
  - fix(app): search every known project in the open project dialog (#40202)
- @MagnumGoYB:
  - docs: remove obsolete vouch system section (#40266)
- @frederiknsgo:
  - fix: gpt-5.5+ in combination with azure fails with reasoningEffort (#40265)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.12)

## 1.18.11 (2026-08-02)

Updated to upstream OpenCode **1.18.11**:

### Core

### Bugfixes

- Stopped MCP SSE connections from getting stuck in reconnect loops after server error responses.
- Fixed provider model configs that use interleaved reasoning fields like `reasoning_text` or custom field names.

### Desktop

### Bugfixes

- Open external links in the system browser instead of inside the app.
- Fixed stale session tab state in the desktop title bar. (@OpeOginni)
- Open the legacy directory picker at your home folder when no home path is loaded yet.
- Prevent the file tree tab from clipping when resized smaller. (@OpeOginni)
- Fixed debug gutter labels and values misaligning.

**Thank you to 2 community contributors:**
- @devennavani:
  - docs: add Modal provider setup (#39710)
- @OpeOginni:
  - fix(app): prevent file tree tab clipping (#39770)
  - fix(app): prevent stale session tab reads (#39767)
  - fix(app): prevent stale prompt control reads (#39842)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.11)

## 1.18.10 (2026-07-31)

Updated to upstream OpenCode **1.18.10**:

### Core
- Discover available Modal models automatically. (@devennavani)

### Desktop
### Improvements
- Prevent adding the same attachment more than once.
- Always show the new session button.
- Improve toast notifications with better stacking, dismissal, and mobile layout.
- Refine tab hover, active, and overflow states.

### Bugfixes
- Repair malformed saved tabs so broken tab state no longer persists across launches. (@OpeOginni)
- Hide the model variant selector until model data finishes loading.
- Preserve the custom agent picker for existing users.

**Thank you to 3 community contributors:**
- @lakshyaag-tavily:
  - docs(ecosystem): add opencode-tavily plugin (#38709)
- @devennavani:
  - feat: discover Modal models (#39066)
- @OpeOginni:
  - fix(app): repair malformed persisted tabs (#39645)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.10)

## 1.18.9 (2026-07-29)

Updated to upstream OpenCode **1.18.9**:

### Core
### Bugfixes
- Restored compatibility with legacy MCP SDK clients.

### Desktop
### Bugfixes
- Fixed a Solid cleanup crash that could break navigation in the desktop app.
- Fixed home session loading so the session list can update without suspending the whole page.

### Improvements
- Removed the extra vertical borders from the V2 home projects view.
- Added an opt-in V2 desktop sidecar backed by the bundled CLI service.
- Added collapsible model provider sections in V2 settings.

**Thank you to 1 community contributor:**
- @roborew:
  - fix(desktop): patch @dnd-kit/solid to preserve core scroll plugins (#38119)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.9)

## 1.18.7 (2026-07-28)

Updated to upstream OpenCode **1.18.7**:

### Desktop
### Bugfixes
- Remove the extra titlebar inset in fullscreen on macOS.
- Keep command palette entries from reappearing incorrectly when shadowed commands are removed.
- Add scrolling to the project selector dropdown when the list is long. (@david1gp)

**Thank you to 2 community contributors:**
- @ProdigyRahul:
  - fix(ui): keep mutable selects open (#39027)
- @david1gp:
  - fix(app): add scroll to project selector dropdown (#39016)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.7)

## 1.18.6 (2026-07-27)

Updated to upstream OpenCode **1.18.6**:

### Core
### Bugfixes
- Fixed branch-specific repository caches so refreshing one reference no longer moves another branch checkout.

### Desktop
### Improvements
- Improved compatibility with the newer client API across directory, project, session, and terminal flows.

### Bugfixes
- Fixed legacy MCP state refreshing when opening a V1 workspace.
- Fixed provider lists not refreshing after connecting a provider or finishing provider OAuth on V1 servers.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.6)

## 1.18.5 (2026-07-25)

Updated to upstream OpenCode **1.18.5**:

### Core
### Bugfixes
- Improve Claude adaptive thinking handling across more response shapes.
- Avoid OpenAI Responses phase handling that could break some conversations.
- Preserve grep symlink paths in search results. (@remixz)
- Preserve Mistral reasoning history across turns.
- Stabilize Mistral prompt caching.
- Use the correct prompt cache keys for each SDK.
- Fix MiniMax M3 thinking variant selection.

### Desktop
### Improvements
- Support the current server terminal transport.
- Support current-server review data in the desktop app.
- Update server discovery flows for current servers.
- Support current-server session actions, including prompts and commands.
- Render current-server session timelines.
- Stream current-server events in the desktop app.
- Detect legacy and current servers so the desktop app can work with both.

### Bugfixes
- Restore optimistic timeline updates while responses are still streaming.
- Hide legacy-only features when connected to current servers.
- Preserve inline file mentions when sending prompts to legacy servers.
- Stop auto-accepting config permissions on current servers.
- Keep current servers out of the legacy layout.
- Show plain file contents in file-specific tabs instead of review diffs.
- Keep the prompt input agent toggle in sync.
- Keep paginated session timelines in the right order.
- Restore directory-scoped session status for legacy servers.
- Reload legacy session progress after hydration.

**Thank you to 2 community contributors:**
- @dleopold:
  - fix(app): classify existing web profiles for layout transition (#38117)
- @remixz:
  - fix(opencode): preserve grep symlink paths (#38581)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.5)

## pr-38252-videos (2026-07-22)

Updated to upstream OpenCode **pr-38252-videos**:

Before/after verification recordings for PR #38252.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/pr-38252-videos)

## 1.18.4 (2026-07-21)

Updated to upstream OpenCode **1.18.4**:

### Core

### Improvements

- Use adaptive thinking controls for Kimi models on Anthropic-compatible providers, with summarized reasoning output by default. (@chouqin)

### Bugfixes

- Reduce OpenAI provider header timeouts during slow connection setup.
- Respect provider-defined reasoning options instead of falling back to the wrong reasoning controls.
- Restore Azure Cognitive Services endpoint support for Azure-hosted models.

### Desktop

### Improvements

- Sync the embedded terminal theme with the app theme.
- Improve the review panel so open file tabs can stay aligned with the current diff view.
- Rewrite the v2 prompt input for more reliable command, context, shell, attachment, and history interactions.
- Improve review panel resizing and sticky controls.

### Bugfixes

- Preserve command drafts in the command menu.
- Avoid session view failures when message parent links are missing.
- Prevent sending empty prompt text parts.
- Restore model variant selection accessibility.
- Show keybind tooltips on prompt input controls. (@ProdigyRahul)
- Deduplicate repeated file entries in diff summaries.
- Prevent recovery window handling from touching destroyed windows.

**Thank you to 3 community contributors:**
- @jerome-benoit:
  - fix(nix): relax Bun version check for desktop build (#36767)
  - fix(nix): restore desktop integration (#37197)
- @ProdigyRahul:
  - fix(app): show keybind tooltips on prompt input controls (#37824)
- @chouqin:
  - feat(opencode): use adaptive thinking effort for kimi family on anthr… (#37696)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.4)

## 1.18.3 (2026-07-17)

Updated to upstream OpenCode **1.18.3**:

### Core
### Improvements
- Added an Up Arrow shortcut to close the subagent picker when the first item is selected.

### Desktop
### Bugfixes
- Fixed home page scrolling so sticky headers and the session list behave correctly.
- Fixed startup readiness so WSL server loading is included before the desktop app reports ready.
- Removed the inactive help button from the app layout.
- Fixed custom agent selector visibility when custom agents are available.

### Improvements
- Home page command palette search can now find and open sessions.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.3)

## 1.18.2 (2026-07-16)

Updated to upstream OpenCode **1.18.2**:

### Core

### Bugfixes

- Stopped subagents from launching nested subagents by default, with a configurable `subagent_depth` limit when needed.
- Improved default reasoning depth for Meta models.

### Desktop

### Improvements

- Added `Mod+N` as another shortcut for opening a new tab.

### Bugfixes

- Restored the Help button in release builds.
- Kept sessions with `null` archive times visible instead of dropping them from the home list.
- Hid the drawer close button on Windows where it conflicts with the window chrome.

**Thank you to 1 community contributor:**
- @BB-84C:
  - fix(core): tolerate AlreadyExists in FSUtil.ensureDir (#36542)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.2)

## 1.18.1 (2026-07-15)

Updated to upstream OpenCode **1.18.1**:

### Desktop
### Bugfixes
- Fixed spacing between model provider sections in Settings.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.18.1)

## 1.17.20 (2026-07-14)

Updated to upstream OpenCode **1.17.20**:

### Core
### Bugfixes
- Removed an obsolete Codex workaround that could interfere with OpenAI Luna Responses Lite requests.

### Improvements
- Updated Azure AI support for GPT-5.6.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.20)

## 1.17.18 (2026-07-10)

Updated to upstream OpenCode **1.17.18**:

### Core

### Bugfixes

- Prevent crashes and bad pricing data when GitHub Copilot returns models with a zero billing batch size.

### Improvements

- Add a model-specific system prompt for Meta Muse Spark.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.18)

## 1.17.15 (2026-07-08)

Updated to upstream OpenCode **1.17.15**:

### Core
### Bugfixes
- Better classify Z.ai context-window overflow errors so oversized requests surface the right failure mode (@fengjikui)
- Handle unavailable config directories more gracefully when reading config files

### Desktop
### Improvements
- Restore model details tooltips in the model picker (@arvsrn)
- Refresh the v2 command palette to better match the rest of the new desktop UI (@arvsrn)

### Bugfixes
- Make terminal shortcuts take priority when the terminal is focused
- Show unread state on tabs with pending questions
- Keep session tab titles available after reloads while session data is still loading
- Apply theme changes only after you select them in Settings
- Fix macOS titlebar appearance mismatches in Sequoia and adjust traffic light placement (@arvsrn)

**Thank you to 3 community contributors:**
- @arvsrn:
  - feat(app): align cmd k menu with v2 styles (#35152)
  - feat(app): visual improvements (#35134)
  - feat(app): reintroduce model context tooltip in model selector (#35087)
  - feat(app): change traffic light position, fix sequoia bug (#35081)
- @StarpTech:
  - fix(core): expand home-relative permission paths (#35737)
- @fengjikui:
  - fix(llm): classify zai token limit overflow (#35671)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.15)

## 1.17.13 (2026-07-02)

Updated to upstream OpenCode **1.17.13**:

### Core

### Bugfixes

- Force reasoning mode for OpenAI-compatible reasoning models so reasoning settings apply reliably on custom deployments
- Stop replaying stale GitHub Copilot response item IDs, avoiding follow-up request failures

### Desktop

### Bugfixes

- Let question prompts be minimized and restored without dismissing them (@arvsrn)
- Clean up stale empty and old draft store files to reduce desktop state buildup
- Keep pending question requests open while reviewing them, instead of dismissing them accidentally (@eXamadeus)
- Keep session page failures scoped to the affected tab instead of breaking the whole app

### Improvements

- Improve markdown and message layout alignment in the v2 session UI (@arvsrn)
- Add a searchable v2 model picker and model management flow in the composer (@arvsrn)
- Show a hover preview for session tabs with the project, path, branch, and server (@usrnk1)
- Streamline WSL server setup with clearer distro checks and install flows (@arvsrn)
- Keep desktop tabs scoped to each window so windows restore their own tab sets

**Thank you to 3 community contributors:**
- @arvsrn:
  - feat(app): v2 wsl ui (#34233)
  - feat(app): composer improvements (#34720)
  - feat(app): more v2 ui alignment (#34465)
  - feat(app): minor fixes (#34748)
- @eXamadeus:
  - fix(app): question UI fixes and UX improvements (#34116)
- @usrnk1:
  - feat(desktop): session tab hover preview popover (#34678)
  - feat(desktop): improve markdown heading spacing in session timeline (#34738)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.13)

## 1.17.12 (2026-07-01)

Updated to upstream OpenCode **1.17.12**:

### Core
### Bugfixes
- Enable adaptive thinking for Claude Sonnet 5.
- Prefer MCP content responses over structured output when both are present.
- Reconnect MCP servers after OAuth even if the server was disabled. (@MaxAnderson95)
- Request MCP refresh-token scope during OAuth.
- Show MCP OAuth completion errors instead of a generic failure.
- Refresh cached remote skills.
- Preserve skill resource paths.
- Pick better default small models across providers.
- Scope MCP auth status to each server URL.

### TUI
### Improvements
- Add a yolo mode to auto-approve permissions.
- Pass ServerAuth headers through external served TUI connections. (@OpeOginni)

### Desktop
### Improvements
- Autocomplete MCP resources in the composer.
- Add workspace controls when starting a new session.
- Show stored token and cost totals in the session context. (@OpeOginni)

### Bugfixes
- Autocomplete configured references in prompts.
- Restore the prompt cursor when the composer regains focus.
- Remember the last active desktop URL across restarts.
- Preserve the selected model when promoting a session. (@usrnk1)
- Keep session pages in sync during concurrent events.
- Support normal auth input prompts in the desktop connect-provider dialog. (@OpeOginni)
- Prevent hidden terminal tabs from hanging or resizing incorrectly.
- Re-enable auto-accept in session settings.
- Keep session tabs scoped to the correct server.
- Remember the selected home project and server.

### SDK
### Improvements
- Add a live event subscription stream.
- Add SDK access to active sessions.
- Restore session runtime operations such as event streaming, interrupts, and message lookup.
- Add paged durable session history.
- Add session permission request create and fetch endpoints.

### Bugfixes
- Preserve `V2Event` names in SSE streams.
- Wake embedded session execution after new prompts.
- Improve V2 runtime tool results and avoid duplicate model switch events.
- Resolve MIME types for prompt attachments sent by URI.

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.12)

## 1.17.11 (2026-06-26)

Updated to upstream OpenCode **1.17.11**:

### Core
### Improvements
- Add session snapshots and revert controls so you can roll a session back to an earlier message, including file changes.

### Bugfixes
- Always print the MCP OAuth URL so manual sign-in still works when opening the browser flow.

### Desktop
### Improvements
- Add Chrome-style tab cycle shortcuts with `mod+1` through `mod+9`.
- Add draggable tabs. (@arvsrn)
- Improve the empty home state when you have no sessions. (@arvsrn)
- Restyle the jump-to-latest button in the v2 session view. (@arvsrn)
- Improve the redesigned desktop layout, including better titlebar tabs and archived sessions. (@arvsrn)

### Bugfixes
- Keep prompt drafts attached to the correct project server.
- Restore consistent titlebar tab sizing and layout.
- Restore home actions when session lists are empty or still loading.
- Keep todo docks in place when switching between sessions.
- Automatically close tabs for sessions that no longer exist.
- Keep provider dialogs, prompt rollbacks, and async attachments tied to the session where they started.
- Clear late session notifications after you open the session.
- Remove the session loading stripe.

**Thank you to 2 community contributors:**
- @isaachuangGMICLOUD:
  - docs: add GMI Cloud provider entry to providers directory (#32914)
- @arvsrn:
  - feat(app): draggable tabs (#31364)
  - feat(app): ui improvements (#32438)
  - fix(app): update all v1 new-session icons (#32017)
  - feat(app): no sesssions empty state (#33315)
  - feat(app): restyle v2 jump-to-latest button (#33809)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.11)

## 1.17.10 (2026-06-25)

Updated to upstream OpenCode **1.17.10**:

### Core

### Improvements

- Added MCP server instructions to session context. (@Arcadi4)
- Added Opencode-managed provider integration support.
- Added MCP resource template listing.
- Added MCP resource read tools.
- Added a `--mini` CLI mode.

### Bugfixes

- Hid MCP resource template tools when access is denied.
- Prevented MCP resource tools from colliding when servers expose the same keys.
- Emitted skill base directories as filesystem paths instead of `file://` URLs. (@shyuan)
- Restored legacy MCP tool names for existing integrations.
- Restored v1 account config loading.
- Bound MCP OAuth callbacks to IPv4 loopback for better local auth reliability. (@he-yufeng)
- Preserved structured error details in surfaced failures.
- Fixed snapshots from subdirectories so they only include the right files and paths.
- Fixed ACP resource text sourcing on Windows and other cross-platform path cases.
- Preserved file source paths in ACP resource text.
- Waited for plugins before loading reference-backed config and system context.
- Hid `gpt-5.5-pro` when using Codex OAuth.

### TUI

### Improvements

- Added a configurable keybind to open the diff viewer.
- Added diff viewer support for comparing against the main branch.

### Bugfixes

- Prevented worker rejections from breaking the TUI process.

### Desktop

### Improvements

- Kept draft prompt state per tab.
- Added a new session progress indicator. (@arvsrn)
- Added mobile bottom navigation.
- Added collapsible server sections. (@arvsrn)
- Added server-aware session routes to keep same-session navigation separated across servers.

### Bugfixes

- Always applied safe-area insets.
- Made session navigation more stable and faster.
- Routed new sessions through tabs correctly.
- Cleared viewed session notifications reliably.
- Scoped drafts created from Home to the right server and project.
- Throttled directory tree loading.
- Persisted drafts and prompt state more reliably.
- Improved iOS PWA shell behavior.
- Refined the mobile session layout.
- Added the server button dropdown. (@arvsrn)
- Restored review line comments.
- Improved the mobile home layout.

### SDK

### Improvements

- Exposed provider integration IDs in the SDK.

### Extensions

### Improvements

- Added namespaced plugin hook APIs.
- Added the V2 plugin API for Effect and Promise plugins.

**Thank you to 6 community contributors:**
- @remorses:
  - feat(llm): add video and audio media support to Gemini protocol (#31889)
- @arvsrn:
  - feat(app): collapsible servers (#33384)
  - fix(app): add server button dropdown (#33358)
  - feat(app): new session progress indicator (#32662)
  - feat(app): update all components to use v2 tokens (#33598)
- @ReStranger:
  - fix: Skip bun version check for nix version (#33166)
- @he-yufeng:
  - fix(mcp): bind oauth callback to IPv4 loopback (#30022)
- @shyuan:
  - fix(skill): emit base directory as filesystem path, not file:// URL (#33580)
- @Arcadi4:
  - feat(mcp): append server instructions to context (#32490)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.10)

## 1.17.9 (2026-06-21)

Updated to upstream OpenCode **1.17.9**:

### Core

### Bugfixes

- Honor configured agent step limits by forcing a final text response instead of failing mid-run.
- Fix Devstral model detection when provider IDs use different casing. (@Robin1987China)
- Pass configured custom headers to Copilot model requests.

### Improvements

- Add `high` and `max` thinking variants for GLM-5.2 across supported providers. (@imranshaiedi-byte)
- Stop wrapping follow-up user messages in a steering reminder so prompt caching stays effective.

### TUI

### Bugfixes

- Only show the background subagent shortcut when the server supports it.

**Thank you to 4 community contributors:**
- @Grantmartin2002:
  - fix(core): fix command docs in customize-opencode skill (#32718)
- @Robin1987China:
  - fix(opencode): use toLowerCase for Devstral model detection (#33109)
- @kimnamu:
  - fix(experimental llm pkg): forward topK to Converse via additionalModelRequestFields (#33030)
- @imranshaiedi-byte:
  - feat(opencode): expose High/Max thinking variants for GLM-5.2 (#32446)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.9)

## 1.17.8 (2026-06-18)

Updated to upstream OpenCode **1.17.8**:

### Core
### Improvements
- Session timelines load much faster and avoid flicker or scroll jumps.

### Bugfixes
- OpenAI-compatible providers now accept MCP tool schemas that previously failed validation. (@jquense)
- Cloudflare AI Gateway now receives the configured API key correctly. (@keefetang)
- MCP tools without declared schema properties now work with providers that expect object properties.
- Long-running MCP tools now keep their timeout alive when they report progress. (@Nomadcxx)
- The MCP OAuth callback server now shuts down once authorization finishes or is cancelled.
- MCP tool failures now surface the server's error text instead of a generic failure.
- MCP OAuth error pages now escape provider error text correctly.

### Desktop
### Improvements
- Added a Home tab toggle so you can quickly switch between Home and your last tab.
- The new desktop file and folder picker is faster and easier to navigate in the v2 layout.

**Thank you to 3 community contributors:**
- @Nomadcxx:
  - fix(mcp): enable progress timeout resets (#32477)
- @keefetang:
  - fix(provider): pass apiKey to createUnified for Cloudflare AI Gateway (#32052)
- @jquense:
  - fix(opencode): sanitize OpenAI MCP tool schemas (#32489)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.8)

## 1.17.7 (2026-06-15)

Updated to upstream OpenCode **1.17.7**:

### Core

### Bugfixes

- Plugin client requests now reuse the active server instead of assuming the default local port.
- ACP shell tool calls now show the command and working directory from the start.
- Plugin-provided shell environment variables now apply to PTY sessions.

### Improvements

- MCP servers can now receive the current workspace as a client root.

### TUI

### Bugfixes

- MCP debug now uses the SDK's latest protocol version.

### Desktop

### Bugfixes

- The new session route now stays scoped to its own draft server, so prompts and state target the right workspace.

### SDK

### Improvements

- SDK clients now refresh model and provider availability when integrations change, and credential update and remove calls accept `location`.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.7)

## 1.17.6 (2026-06-14)

Updated to upstream OpenCode **1.17.6**:

### Core
### Bugfixes
- Improved MCP server compatibility by declaring OpenCode's supported client capabilities.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.6)

## 1.17.4 (2026-06-12)

Updated to upstream OpenCode **1.17.4**:

### Core

### Improvements

- Added `cwd` support for local MCP servers so they can start from a workspace-relative directory. (@Grantmartin2002)
- Added connector-based authentication flows and support for stored provider credentials.
- Added v2 API endpoints to create and fetch sessions, list session questions, and resolve the active location.
- File reads now return raw content with the correct content type for API and SDK clients.
- MCP server log notifications are now surfaced in opencode logs.

### Bugfixes

- Fixed Gemini tool schemas that used multi-type fields so compatible tools keep working. (@Killusions)
- Content-filtered model responses now surface as visible errors instead of failing silently. (@kkdawkins)
- Fixed MCP auth and debug requests dropping configured headers.
- Snapshot creation now reuses source Git objects to avoid long re-hashing delays on huge repos. (@dmtrKovalenko)
- Fixed MCP catalog request timeouts not applying when listing prompts, resources, or tools.

**Thank you to 5 community contributors:**
- @dmtrKovalenko:
  - fix(snapshot): reuse source git objects to avoid re-hashing huge repos (#31798)
- @tobwen:
  - fix(tui): preserve exit epilogue during scoped shutdown (#31805)
- @kkdawkins:
  - fix(opencode): surface content-filter finish reason as visible error (#31745)
- @Killusions:
  - fix(gemini): prevent gemini incompatibility with some tools (#31877)
- @Grantmartin2002:
  - feat(opencode): support cwd on local MCP servers (#30676)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.4)

## 1.17.3 (2026-06-11)

Updated to upstream OpenCode **1.17.3**:

Fixed issue with 1.17.2 desktop crashing

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.3)

## 1.17.0 (2026-06-10)

Updated to upstream OpenCode **1.17.0**:

### Core
### Improvements
- Faster file search across large projects with the new `fff`-backed search tools. (@dmtrKovalenko)
- Added `X-Session-Id` headers for proxy setups that need sticky routing. (@songchaow)
- Added Cohere North model support.
- Added `reasoning` as an interleaved field option for vLLM providers. (@delta9000)
- `mcp add` now works in non-interactive flows.
- `auth logout` now supports search when choosing an account.

### Bugfixes
- Improved MCP connection status messages so failures are easier to act on.
- Added Claude Fable reasoning support.
- MCP tool calls now receive abort signals, so cancellations stop more reliably.
- MCP catalogs now paginate correctly instead of truncating larger lists.
- OpenRouter reasoning variants now generate for all models. (@AnthonyMLau)
- Added MiniMax M3 thinking toggle support.
- Java multi-module Maven workspaces now resolve JDTLS from the topmost `pom.xml`. (@areyouok)
- MCP servers now respect advertised capabilities.
- Session lists now respect directory filters in workspace setups. (@rexdotsh)
- Sessions can recover once from provider context-overflow errors instead of failing immediately.
- Bedrock Mantle config now honors configured API key and region settings.

### TUI
### Improvements
- The session move flow now highlights project copies more clearly and keeps the current location selected.
- Project copies can now be deleted directly from the move dialog.

### Bugfixes
- New project copies are now bootstrapped before the TUI switches into them.
- Moving a session now injects a reminder about the new working directory.

### Desktop
### Improvements
- Added a help button to the tabs bar.
- Prompt drafts are preserved while you switch tabs.
- File attachments now open in the active project.
- App updates now stay responsive and persist across restarts.
- Added WSL-backed Desktop support and WSL server management on Windows.
- Improved the sessions list UI. (@arvsrn)
- Improved the servers UI. (@arvsrn)

### Bugfixes
- Updated Electron and fixed related panel layout issues.
- Fixed several WSL Desktop bugs. (@neriousy)
- Hidden agents no longer get cycled accidentally.
- MCP status now refreshes when the active directory changes.
- The Home screen now keeps a larger recent-session list with scrolling.

### SDK
### Improvements
- Large v2 tool outputs are now bounded and expose retained output paths for follow-up inspection.

**Thank you to 11 community contributors:**
- @rexdotsh:
  - fix(session): respect directory filter with workspaces (#30804)
- @arvsrn:
  - feat(app): improve servers UI (#30961)
  - feat(app): updates to project avatar (#30964)
  - feat(app): sessions list improvements (#30941)
- @dmtrKovalenko:
  - feat(opencode): fff search tools (#27802)
- @fancive:
  - docs: fix MCP header interpolation example to {env:VAR} (#31078)
- @robertDouglass:
  - fix(tui): sort connect providers alphabetically (#30891)
- @neriousy:
  - fix(desktop): few WSL bugs (#31095)
- @areyouok:
  - fix(lsp): resolve JDTLS root to topmost pom.xml in Java Maven multi-module projects (#28761)
- @remorses:
  - fix(session): merge per-call tool rules into session permission (#30529)
- @AnthonyMLau:
  - fix(opencode): generate reasoning variants for all OpenRouter models. (#30332)
- @delta9000:
  - feat: add "reasoning" as interleaved field option for vLLM providers (#30477)
- @songchaow:
  - feat: add X-Session-Id header for proxy cache routing affinity (#31511)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.17.0)

## 1.16.2 (2026-06-06)

Updated to upstream OpenCode **1.16.2**:

### Core

### Bugfixes

- Reasoning summaries now only run on providers that support them, avoiding GPT-5 request failures on compatible backends.
- Edit operations now refuse loose matches that could overwrite the wrong code or replace an existing file by mistake.
- Fixed Bedrock sessions hanging before a model response starts. (@alblez)

### Improvements

- Diff viewer now supports next and previous hunk navigation.
- Terminal themes now refresh after live terminal reloads without stale colors or broken highlighting.
- Running subagents can now be sent to the background so you can keep working.
- Sessions now persist system context updates during long-running conversations.
- Added Snowflake Cortex provider support. (@kameshsampath)

### TUI

### Bugfixes

- Fixed the external editor fallback so attach-mode sessions still open when the original project path is unavailable locally. (@pcadena-lila)
- Permission replies now route through the correct session directory.
- `/mo` now prefers the models command in slash autocomplete.
- Fixed crashes from malformed path or diff metadata in permission and session views.

### Desktop

### Bugfixes

- Fixed titlebar tab overflow clipping.
- Fixed overflowed titlebar tabs so scrolling and drag regions behave correctly.
- Improved tab closing and navigation so the next tab is selected more reliably.

### Improvements

- Improved multi-server desktop support with per-server home state and session tabs.

**Thank you to 5 community contributors:**
- @kameshsampath:
  - feat(core): add Snowflake Cortex provider (#29901)
- @pcadena-lila:
  - fix(tui): fall back to local cwd when editor spawns in attach mode (#30583)
- @weiconghe:
  - fix: use mapError instead of orDie for context snapshot decoding (#30905)
- @alblez:
  - fix(opencode): resolve Bedrock hang by using node build conditions (#30873)
- @jerome-benoit:
  - fix(workflows): retry nix-hashes compute-hash on transient failure (#30743)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.16.2)

## 1.16.0 (2026-06-05)

Updated to upstream OpenCode **1.16.0**:

### Core

### Improvements

- Added managed workspace cloning that keeps dirty and untracked files.
- Added moving sessions between workspaces and directories.
- Added proper OpenAI model support through AWS Bedrock.
- Added skill discovery and file-based agent loading.
- Updated GitHub Copilot usage tracking for token-based billing.
- Added `run --replay` for interactive session replay.
- Improved startup time. (@StarpTech)

### Bugfixes

- Added Vue syntax highlighting.
- Restored full ACP session replay when loading saved sessions. (@imnotlxy)
- Fixed shell cancellation races.
- Fixed SAP AI Core OpenAI reasoning variants. (@jerome-benoit)
- Fixed delegated tasks losing their selected reasoning variant.
- Fixed OpenAI websocket sessions getting stuck idle.
- Fixed Windows path normalization in migrated storage.
- Fixed prompt corruption when pasting near wide characters. (@dauphinYan)
- Fixed ACP cancel so it aborts the active run. (@smagnuso)
- Fixed SAP AI Core Anthropic Opus 4.7+ adaptive reasoning. (@jerome-benoit)

### TUI

### Improvements

- Improved the experimental session switcher.
- Truncated long sidebar file paths.

### Bugfixes

- Show a toast when the variant hotkey is used with no variants. (@ariane-emory)
- Routed question responses to the right session directory.
- Stopped the background task spinner from sticking.

### Desktop

### Improvements

- Added color themes. (@arvsrn)
- Show local server startup failures in the app.
- Added a thinking level selector for v2 prompts.
- Added a Servers tab in Settings.
- Added an update button. (@arvsrn)

### Bugfixes

- Fixed session review refresh and VCS diff caching.
- Hid update actions when desktop updates are unavailable.
- Fixed tab title truncation and close button placement.
- Show project sessions before path sync finishes. (@mhart)

### SDK

- Exposed session location data in v2 responses.

### Extensions

### Bugfixes

- GitHub now refuses to commit without an existing git author identity. (@ulises-jeremias)

**Thank you to 10 community contributors:**
- @jerome-benoit:
  - fix(opencode): support sap-ai-core anthropic opus 4.7+ adaptive reasoning (#29991)
  - fix(opencode): route SAP AI Core reasoning variants through modelParams (#30482)
- @mhart:
  - fix(app): show project sessions before path sync resolves (#30167)
- @smagnuso:
  - fix(acp): honor session/cancel by aborting the running turn (#30145)
- @dauphinYan:
  - fix(tui): prevent prompt corruption when pasting near wide characters (#29710)
- @arvsrn:
  - feat(app): v2 desktop UI improvements (#29689)
  - feat(app): polish home projects list UI (#30436)
  - feat(app): polish select-v2 component (#30446)
  - feat(app): new update button  (#30460)
  - feat(app): color themes (#30824)
- @StarpTech:
  - refactor(opencode): improve startup time by 38% (#30453)
- @ulises-jeremias:
  - fix(github): enforce existing git author identity (#30507)
  - fix(opencode): fallback to sh for curl upgrade (#30499)
- @ariane-emory:
  - fix(tui): show toast when variant_list keybind used with no variants (#30724)
- @imnotlxy:
  - fix(opencode): `ACP.loadSession` should replay all messages (#30761)
- @colinhacks:
  - fix: bump @openrouter/ai-sdk-provider to 2.9.0 (#30800)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.16.0)

## 1.15.13 (2026-05-31)

Updated to upstream OpenCode **1.15.13**:

### Core

### Bugfixes

- Gateway Anthropic Opus 4.7+ adaptive reasoning now keeps summarized thinking instead of returning empty thinking blocks.

### Improvements

- Sessions can now store custom metadata through the API and SDK. (@shantur)
- Config now loads from the opened location upward, so directory-specific settings and provider policies apply more predictably.

### TUI

### Bugfixes

- Wrapped inline tool rows now stay aligned, and failed inline tools can expand their error details in place.

**Thank you to 1 community contributor:**
- @shantur:
  - feat(core): add session metadata support (#23068)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.15.13)

## pr-29948-screenshots (2026-05-30)

- Update to upstream pr-29948-screenshots
- Upstream release notes: https://github.com/anomalyco/opencode/releases

## 1.15.12 (2026-05-29)

Updated to upstream OpenCode **1.15.12**:

### Core
### Improvements
- ACP integrations can now send prompts, slash commands, and usage updates through `acp-next`
- Added WebSocket transport for OpenAI responses on supported channels (set OPENCODE_EXPERIMENTAL_WEBSOCKETS=true)

### Bugfixes
- Enabled adaptive reasoning controls for Anthropic Opus 4.7+ models
- Allowed colons in passwords (@neriousy)
- Sped up warm `acp-next` model and config switches
- Improved first-session `acp-next` startup time
- Kept OpenAI WebSocket response timeouts active
- Retried failed OpenAI WebSocket streams before falling back
- Handled `acp-next` permission prompts correctly
- Used the persisted session directory for existing-session requests
- Forwarded remote workspace request bodies correctly
- Supported custom base URLs for OpenAI WebSocket responses (@Tarquinen)

### TUI
### Improvements
- Added a workspace management dialog

### Bugfixes
- Kept session navigation working while prompt modes are open
- Restored the thinking spinner
- Surfaced subagent retry status
- Fixed opening editors from non-Git project paths (@OpeOginni)

### Desktop
### Improvements
- Added a setting to switch tab layouts

### Bugfixes
- Improved the home empty state and fixed V2 font usage
- Fixed tab close buttons not showing reliably

**Thank you to 5 community contributors:**
- @OpeOginni:
  - fix(tui): handle non-git project paths when opening editor (#29180)
- @gotjoshua:
  - docs: fix ts error in math examples (#18244)
- @Tarquinen:
  - fix(openai): support websocket custom base URLs (#29636)
- @24KaratAu:
  - docs: fix grammar in config.mdx (#29683)
- @neriousy:
  - fix(core): allow colons inside passwords (#29576)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.15.12)

## 1.15.11 (2026-05-27)

Updated to upstream OpenCode **1.15.11**:

### Core
### Improvements
- Added `headerTimeout` config for provider requests, with a 10s default for default OpenAI setups.
- Experimental background agents now push updates without polling.
- You can now set only `modalities.input` or `modalities.output` in config. (@robposch)
- Remote-backed projects now resolve a stable project identity.

### Bugfixes
- Dynamically added MCP servers now disconnect cleanly when removed.
- DigitalOcean inference now uses your OAuth token directly instead of creating a MAK. (@Spherrrical)
- Config loading now falls back cleanly when user info is unavailable.
- Fixed Google tool calling after the upstream tool ID regression.
- Experimental flags can now override the umbrella experimental flag.
- Resumed sessions no longer continue orphaned interrupted tools. (@edevil)
- OpenAI reasoning summaries now render as separate blocks.
- Updated Google Vertex support for reasoning signatures.
- The shell tool now advertises your configured timeout to the model.

### TUI
### Improvements
- Made the prompt resize with terminal width and added prompt size config. (@bjschafer)

### Bugfixes
- Accelerated diff viewer scrolling.
- External editors now open from the worktree directory when available.

### Desktop
### Improvements
- Refined the Desktop v2 home screen, prompt, status popover, and session controls.

### Bugfixes
- Fixed V2 titlebar errors when a session sync cache was deleted. (@Eric-Guo)
- Web deployments no longer run desktop health checks.
- Duplicate server connections are now merged in the server list.
- Stabilized virtualized session timeline interactions.
- Fixed the white flash when restoring the desktop window.

### Extensions
### Improvements
- Added a `dispose` hook for plugins.

### Bugfixes
- Fixed Codex plugin requests to send the expected session ID header.

**Thank you to 7 community contributors:**
- @jerome-benoit:
  - fix(nix): re-inherit patches in desktop, ad-hoc sign .app on darwin (#27869)
- @edevil:
  - fix(session): exclude orphaned interrupted tools from run-loop continuation (#26178)
- @bjschafer:
  - feat(tui): make prompt size responsive and configurable (#28255)
- @robposch:
  - tweak (config): make modalities input/output fields optional so that u can specify one without both being required  (#29268)
- @Eric-Guo:
  - fix(app): handle deleted session sync cache in V2 titlebar (#29328)
- @StarpTech:
  - docs(web): update LSP docs wording (#29435)
  - docs: add tip to lsp section (#29444)
- @Spherrrical:
  - fix(digitalocean): use OAuth token directly for inference instead of creating MAK (#28897)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.15.11)

## 1.15.10 (2026-05-24)

Updated to upstream OpenCode **1.15.10**:

### Desktop
### Bugfixes
- Restored the legacy production desktop flows for opening projects and starting sessions.

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.15.10)

## 1.15.5 (2026-05-19)

Updated to upstream OpenCode **1.15.5**:

### Core

### Improvements

- Preview the native OpenAI runtime path behind an experimental flag
- Add `--replay` and `--replay-limit` to show recent history when resuming interactive runs

### Bugfixes

- Fix plugin tools using `ask` so tool calls complete correctly
- Reduce missed `/event` updates caused by a subscription race
- Sort the v2 session list by most recently updated

### TUI

### Improvements

- Refresh the prompt layout after pasting content

### Bugfixes

- Keep file references scoped to the current workspace
- Preserve pasted prompt content when copying
- Collapse very long tool output lines to keep the layout readable
- Use a higher-contrast paste summary badge color in some themes (@kagura-agent)

### Desktop

### Improvements

- Allow desktop notifications from the renderer
- Show free-limit and usage-exceeded dialogs in Desktop
- Speed up large session timelines

### Bugfixes

- Fix question dock overflow and message layout clipping
- Hide the prompt placeholder when the input only contains whitespace (@ShrootBuck)
- Sync the PWA status bar color with the active theme (@heimoshuiyu)
- Install the newest available desktop update instead of reusing a stale download

**Thank you to 4 community contributors:**
- @heimoshuiyu:
  - fix: sync PWA status bar theme-color with app color scheme (#28006)
- @ShrootBuck:
  - fix(app): hide prompt placeholder for whitespace input (#28101)
- @kagura-agent:
  - fix(tui): use contrast-aware foreground for paste summary badge (#27969)
- @SpiritChen51:
  - fix(ui): fallback to execCommand for clipboard copy when navigator.clipboard fails (#27993)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.15.5)

## 1.14.48 (2026-05-12)

Updated to upstream OpenCode **1.14.48**:

### Core
### Improvements
- Preserve original image attachments instead of resizing them before sending them to the model

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.14.48)

## 1.14.31 (2026-05-01)

Updated to upstream OpenCode **1.14.31**:

### Core
- Azure setup now prompts for the resource name when needed and saves it with the API key.
- Task child sessions now preserve parent `external_dir` and deny permissions. (@remorses)
- Invalid remote MCP URLs now fail with a clear error instead of breaking setup.

### Desktop
- Restoring saved messages no longer crashes the app when a model is missing.

**Thank you to 1 community contributor:**
- @remorses:
  - fix(opencode): preserve `external_dir` and `deny` parent permissions in task child sessions (#23290)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.14.31)

## 1.14.28 (2026-04-27)

Updated to upstream OpenCode **1.14.28**:

### Core

- Fixed issue with `opencode upgrade` failing for bun installs unless in a directory with package.json

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.14.28)

## 1.14.25 (2026-04-25)

Updated to upstream OpenCode **1.14.25**:

### Core

- Fixed permission config preserving rule order and exposes full IntelliSense for tool permission keys
- LSP permission prompts now include request details like the operation, file, and cursor position
- Shell commands keep the correct working directory after login shell startup files run
- Added Roslyn LSP support for Razor, `.cshtml`, and C# script files
- GPT-5.5 with OpenAI OAuth now uses the correct context limits to avoid compaction issues

**Thank you to 2 community contributors:**
- @altendky:
  - fix(opencode): clarify git amend condition to require verifying commit landed (#19937)
- @b0o:
  - fix(build): add prettier to devDependencies (#23255)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.14.25)

## 1.14.24 (2026-04-25)

Updated to upstream OpenCode **1.14.24**:

### Core
- Fixed DeepSeek assistant messages so reasoning is always included, avoiding provider formatting failures.
- Fixed inherited model configs so interleaved-capability models keep working when that field falls back to an existing model. (@07akioni)
- Added an experimental HTTP API endpoint for MCP server status.
- Added experimental HTTP API endpoints to list files, read file contents, and check project file status.

**Thank you to 1 community contributor:**
- @07akioni:
  - fix: use existingModel as fallback for interleaved field (#24172)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.14.24)

## 1.4.3 (12-04-2026)

- Minor bugs fixed

## 1.4.3

- Initial release
- Based on opencode v1.4.3
- Web UI with HA ingress support
- Configurable workspace directory
- Server password authentication
- Custom environment variables support

### Upstream OpenCode 1.4.3

### Core

- Fixed `agent create` for OpenAI accounts authenticated with OAuth.
- Interrupted Bash commands now keep their final output and truncation details instead of ending as aborted.
- Added fast mode variants for supported Claude and GPT models.

### TUI

- Restored the hidden session scrollbar as the default.

### Extensions

- Added configurable OAuth redirect URIs for remote MCP servers. (@egze)

**Thank you to 2 community contributors:**
- @egze:
  - feat(mcp): add OAuth redirect URI configuration for MCP servers (#21385)
- @simonklee:
  - opencode: lazy-load top-level CLI commands
  - Revert "opencode: lazy-load top-level CLI commands" (#21726)

[Full release notes](https://github.com/anomalyco/opencode/releases/tag/v1.4.3)
