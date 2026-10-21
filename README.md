# Fuzzy Clock for macOS

A menu bar app that tells the time the way people say it: "Quarter past three", "Nearly noon".

Click it for the exact time and date.

A native Swift port of [fuzzy-clock-rust](https://github.com/fuzzy-mode/fuzzy-clock-rust).

## Requirements

- macOS 27
- Xcode 27
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

## Usage

```sh
make install   # build, copy to /Applications, and launch
make test      # run the unit tests
```

To start it at login, add it in System Settings → General → Login Items.
