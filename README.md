# swls-flake

[Semantic Web Language Server](https://github.com/SemanticWebLanguageServer/swls)
— Turtle, TriG, JSON-LD and SPARQL — packaged from the upstream release
binaries.

Nothing is rebuilt: the flake pins the version and the sha256 of each upstream
asset in `version.json`, and installs the binary with `autoPatchelfHook`.

## Packages

| Attribute | Contents |
|---|---|
| `packages.<system>.default` | `swls` |
| `packages.<system>.swls` | alias of `default` |

`overlays.default` provides `pkgs.swls`.

## Usage

```nix
{
  inputs.swls-flake.url = "github:atomic-235/swls-flake";
  inputs.swls-flake.inputs.nixpkgs.follows = "nixpkgs";
}
```

```nix
nixpkgs.overlays = [ inputs.swls-flake.overlays.default ];
# pkgs.swls
```

## Updates

CI runs weekly (Monday 06:00 UTC): resolve the latest upstream release
(`swls-v<version>`), download both Linux assets, hash them, write
`version.json`, build, commit and tag `v<version>`.

Supported: `x86_64-linux`, `aarch64-linux`.
