var http = require('http');
var net = require('net');

var BACKEND_HOST = '127.0.0.1';
var BACKEND_PORT = 80;
var PROXY_PORT = 8133;
var BACKEND_PREFIX = '/audiobookshelf';

function shouldRewrite(contentType) {
    if (!contentType) return false;
    var ct = contentType.toLowerCase();
    return (
        ct.includes('text/html') ||
        ct.includes('application/javascript') ||
        ct.includes('application/json') ||
        ct.includes('text/css')
    );
}

var server = http.createServer(function (clientReq, clientRes) {
    var ingressPath = clientReq.headers['x-ingress-path'] || '';
    var targetPath = ingressPath ? BACKEND_PREFIX + clientReq.url : clientReq.url;

    var fwdHeaders = Object.assign({}, clientReq.headers);
    fwdHeaders.host = BACKEND_HOST + ':' + BACKEND_PORT;
    delete fwdHeaders['x-ingress-path'];
    if (ingressPath) delete fwdHeaders['accept-encoding'];

    var backendReq = http.request(
        {
            hostname: BACKEND_HOST,
            port: BACKEND_PORT,
            path: targetPath,
            method: clientReq.method,
            headers: fwdHeaders
        },
        function (backendRes) {
            var contentType = backendRes.headers['content-type'] || '';

            if (ingressPath) {
                delete backendRes.headers['content-security-policy'];
                if (backendRes.headers['location']) {
                    backendRes.headers['location'] =
                        backendRes.headers['location'].split(BACKEND_PREFIX).join(ingressPath);
                }
            }

            if (ingressPath && shouldRewrite(contentType)) {
                var chunks = [];
                backendRes.on('data', function (chunk) { chunks.push(chunk); });
                backendRes.on('end', function () {
                    var rewritten = Buffer.concat(chunks)
                        .toString('utf8')
                        .split(BACKEND_PREFIX)
                        .join(ingressPath);
                    var outHeaders = Object.assign({}, backendRes.headers);
                    outHeaders['content-length'] = Buffer.byteLength(rewritten);
                    delete outHeaders['transfer-encoding'];
                    clientRes.writeHead(backendRes.statusCode, outHeaders);
                    clientRes.end(rewritten);
                });
            } else {
                clientRes.writeHead(backendRes.statusCode, backendRes.headers);
                backendRes.pipe(clientRes);
            }
        }
    );

    backendReq.on('error', function (err) {
        console.error('[ingress-proxy] backend error: ' + err.message);
        clientRes.writeHead(502, { 'content-type': 'text/plain' });
        clientRes.end('Bad Gateway');
    });

    clientReq.pipe(backendReq);
});

server.on('upgrade', function (req, socket, head) {
    var ingressPath = req.headers['x-ingress-path'] || '';
    var targetPath = ingressPath ? BACKEND_PREFIX + req.url : req.url;

    var rawHeaders = ['GET ' + targetPath + ' HTTP/1.1'];
    Object.keys(req.headers).forEach(function (key) {
        if (key.toLowerCase() === 'x-ingress-path') return;
        if (key.toLowerCase() === 'host') {
            rawHeaders.push('Host: ' + BACKEND_HOST + ':' + BACKEND_PORT);
        } else {
            rawHeaders.push(key + ': ' + req.headers[key]);
        }
    });
    rawHeaders.push('', '');

    var backend = net.connect(BACKEND_PORT, BACKEND_HOST);
    backend.on('connect', function () {
        backend.write(rawHeaders.join('\r\n'));
        if (head && head.length) backend.write(head);
    });
    backend.on('error', function () { socket.destroy(); });
    socket.on('error', function () { backend.destroy(); });
    backend.pipe(socket);
    socket.pipe(backend);
});

server.listen(PROXY_PORT, '127.0.0.1', function () {
    console.log('[ingress-proxy] listening on :' + PROXY_PORT);
});
