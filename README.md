# k0ngk0ng Homebrew Tap

Install `wirectl connect` on Apple Silicon macOS or Linux amd64/arm64:

```sh
brew install k0ngk0ng/tap/wire-connect
wirectl connect setup
wirectl connect login connect.ichenj.com
```

`wire-connect` automatically installs the `wirectl` command host. `setup` requests administrator authorization for the network helper; run it as your ordinary user. The package installer itself does not request elevation or start connections. Server authorization for `login` is separate from OS authorization.

Pair two devices using the [wire-connect instructions](https://github.com/k0ngk0ng/wire-connect#第一次使用). For an existing pair:

```sh
wirectl connect resume
wirectl connect status --watch
```

## Upgrade

```sh
brew update
brew upgrade k0ngk0ng/tap/wirectl k0ngk0ng/tap/wire-connect
wirectl connect setup
wirectl connect resume
```

The last two commands refresh the privileged helper and the saved background connection. Run `resume --name NAME` for other profiles you want active. Stopped profiles do not need to be resumed.

Brew owns these executables. The built-in `wirectl connect update` reports the correct Brew command instead of modifying the Cellar. Ordinary archive installations retain their built-in updater.

If you previously installed binaries in `~/.local/bin`, inspect `type -a wirectl wirectl-connect`. Put Homebrew's `bin` directory first on `PATH`, or remove the old manually installed command files after confirming your new installation. Credentials are stored separately and should not be deleted. To verify the Brew copy explicitly:

```sh
"$(brew --prefix)/bin/wirectl" connect version
```

Bash and Zsh completions are installed in Homebrew's standard completion directories. Enable Homebrew shell completion in your shell as usual.

## Supported platforms

| Package | macOS ARM64 | macOS Intel | Linux AMD64 | Linux ARM64 |
|---|---|---|---|---|
| wirectl | Yes | Yes | Yes | Yes |
| wire-connect | Yes | No | Yes | Yes |

Windows users can use the [Scoop bucket](https://github.com/k0ngk0ng/scoop-bucket).

## Automated maintenance

GitHub Actions checks official stable releases hourly and on manual dispatch. It verifies GitHub asset SHA-256 digests against the separately published `SHA256SUMS`, renders formulas from `release-lock.json`, installs and tests both packages on macOS ARM64 and Linux AMD64/ARM64, then commits the update only after all jobs pass. No cross-repository personal access token is required. GitHub schedules may be delayed; the manual **Sync official releases** workflow can trigger an immediate check.

To prepare the same update locally:

```sh
python3 scripts/sync.py
python3 scripts/sync.py --check
```

`GH_TOKEN` is optional for public API rate limits. Binary archives remain hosted in each project's official GitHub Releases. The Tap contains no private keys, pairing credentials, network state or bundled binaries.
