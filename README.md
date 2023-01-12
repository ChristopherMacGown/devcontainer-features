# devcontainer features

<table style="width: 100%; border-style: none;">
  <tr>
     <td style="width: 140px; text-align: center;">
        A cool icon would be nice here.
     </td>
     <td>
        <strong>
            Devcontainer 'features'<br />
            <em>Simple, reusable features curated by @ChristopherMacGown</em>
        </strong>
    </td>
  </tr>
</table>

This repository contains a _collection_ of features curated by @ChristopherMacGown.

## Collected Features

### mcfly

[mcfly](https://github.com/cantino/mcfly) is a replacement for your default
`ctrl+r` shell history search that uses an intelligent search engine to prioritize
in real-time from your current working directory and recently used commands to
return history suggestions relevant to what you're working on right now.

#### usage
```json 
"features": {
    "ghcr.io/ChristopherMacGown/devcontainer-features/mcfly:1": {}
}
```

Additional options can be found in the [feature documentation](src/mcfly/README.md).

### direnv

[direnv](https://github.com/direnv/direnv) augments shells to load and unload
environment variables based on the current working directory.

#### usage
```json 
"features": {
    "ghcr.io/ChristopherMacGown/devcontainer-features/direnv:1": {}
}
```

Additional options can be found in the [feature documentation](src/direnv/README.md).


### minio-client

[minio-client](https://min.io/docs/minio/linux/reference/minio-mc.html) is an AWS S3
compatible client for S3 and Minio. 

#### usage
```json 
"features": {
    "ghcr.io/ChristopherMacGown/devcontainer-features/minio-client:1": {}
}
```

Additional options can be found in the [feature documentation](src/minio-client/README.md).