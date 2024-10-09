
# easy-container-hooks (easy-container-hooks)

Shell runner that executes hooks in your .devcontainer/hooks/ directory.

## Example Usage

```json
"features": {
    "ghcr.io/kewne/devcontainer-features/easy-container-hooks:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| hooksDir | - | string | .devcontainer/hooks |
| onCreateHookPath | - | string | on-create |
| postAttachHookPath | - | string | post-attach |
| postCreateHookPath | - | string | post-create |
| postStartHookPath | - | string | post-start |
| updateContentHookPath | - | string | update-content |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/kewne/devcontainer-features/blob/main/src/easy-container-hooks/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
