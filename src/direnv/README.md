
# direnv (direnv)

Installs direnv, which augments shells to load an unload environment variables depending on the current directory

## Example Usage

```json
"features": {
    "ghcr.io/ChristopherMacGown/devcontainer-features/direnv:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| architecture | The CPU architecture for the direnv release. | string | amd64 |
| autoEnable | Automatically enable mcfly for bash, zsh, and fish shells. | boolean | true |
| installPath | The path where direnv will be installed. | string | /usr/local/bin/direnv |
| version | Either the latest version or a specific release. | string | latest |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/ChristopherMacGown/devcontainer-features/blob/main/src/direnv/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
