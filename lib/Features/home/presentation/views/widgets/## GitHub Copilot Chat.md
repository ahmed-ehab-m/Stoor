## GitHub Copilot Chat

- Extension Version: 0.26.7 (prod)
- VS Code: vscode/1.99.3
- OS: Windows

## Network

User Settings:
```json
  "github.copilot.advanced.debug.useElectronFetcher": true,
  "github.copilot.advanced.debug.useNodeFetcher": false,
  "github.copilot.advanced.debug.useNodeFetchFetcher": true
```

Connecting to https://api.github.com:
- DNS ipv4 Lookup: 140.82.121.5 (565 ms)
- DNS ipv6 Lookup: Error (243 ms): getaddrinfo ENOTFOUND api.github.com
- Proxy URL: None (1 ms)
- Electron fetch (configured): HTTP 200 (489 ms)
- Node.js https: HTTP 200 (235 ms)
- Node.js fetch: HTTP 200 (244 ms)
- Helix fetch: 