# Labstreaminglayer Tap

Homebrew formulae for [liblsl](https://github.com/sccn/liblsl) and
[LabRecorder](https://github.com/labstreaminglayer/App-LabRecorder) on macOS and Linux.

## Install

```sh
brew install labstreaminglayer/tap/lsl
brew install labstreaminglayer/tap/labrecorder
```

`lsl` installs a regular shared library (`liblsl.dylib` / `liblsl.so`), headers, a CMake
package (`find_package(LSL)`) and a pkg-config file (`pkg-config --libs lsl`). It does
not install `lsl.framework`; download that from the liblsl GitHub releases if you need it.

`labrecorder` installs `LabRecorderCLI` and, on macOS, `LabRecorder.app` under
`$(brew --prefix labrecorder)` plus a `LabRecorder` launcher on your `PATH`. To show it in
Launchpad, symlink the app into `/Applications` (see `brew info labrecorder`).

## Developing

Formulae are bottled (pre-built) for Apple Silicon macOS and x86_64 Linux. Elsewhere
(including Intel Macs, which Homebrew no longer bottles Qt for) `brew install` builds
from source.

To update a formula:

1. On a branch, bump `url` and `sha256` (`curl -sL <url> | shasum -a 256`).
   `brew livecheck <formula>` reports the latest upstream tag. Delete any existing
   `bottle do ... end` block.
2. Run `brew install --build-from-source <formula>`, `brew test <formula>`,
   `brew audit --strict --online <formula>` and `brew style <formula>`.
3. Open a PR. CI runs `brew test-bot` on each platform and uploads the bottles as
   workflow artifacts.
4. Once CI is green, run the **brew pr-pull** workflow (Actions tab, "Run workflow")
   with the PR number. It uploads the bottles to a GitHub release on this repo, adds
   the `bottle` block to the formula, and pushes the result to `main`. Do not merge
   the PR by hand.

`labrecorder` requires `lsl` >= 1.18 (the first release with the `LSL_BUNDLE_DEPENDENCIES`
CMake option, which stops the app from bundling its own copy of liblsl and Qt).
