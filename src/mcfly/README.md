
# mcfly (mcfly)

Installs mcfly, which replaces your shell history with an intelligent search engine.

## Example Usage

```json
"features": {
    "ghcr.io/ChristopherMacGown/devcontainer-features/mcfly:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| architecture | The CPU architecture for the mcfly release. | string | x86_64 |
| autoEnable | Automatically enable mcfly for bash, zsh, and fish shells. | boolean | true |
| installPath | The path where mcfly will be installed. | string | /usr/local/bin/mcfly |
| libc | The GLIBC of the mcfly binary. | string | musl |
| version | Either the latest version or a specific release. | string | latest |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/ChristopherMacGown/devcontainer-features/blob/main/src/mcfly/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
