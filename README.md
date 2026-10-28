# example-tool

A small shell utility that demonstrates packaging for `sstix-tools` across APT, RPM, and Nix with Zsh completion.

## Features
- Stores persistent state under XDG data directories (`$XDG_DATA_HOME/example-tool` or `~/.local/share/example-tool`).
- Supports user configuration under `$XDG_CONFIG_HOME/example-tool` or `~/.config/example-tool`.
- Includes full Zsh autocompletion (`_example-tool`).
- Automated releases for Debian (APT), Fedora/RHEL (RPM), and Nix via GitHub Actions.

## Usage
```bash
example-tool
```

## Zsh Completion
The completion script is installed automatically to `/usr/share/zsh/site-functions/_example-tool` (system packages) or `$out/share/zsh/site-functions/_example-tool` (Nix).

Ensure your `~/.zshrc` has:
```zsh
fpath=(
    "$HOME/.local/share/zsh/functions"
    "$HOME/.local/share/zsh/site-functions"
    $fpath
)
autoload -Uz compinit && compinit
```
