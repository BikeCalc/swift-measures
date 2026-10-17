# Swift Measures Calc

A command-line demo for evaluating expressions, converting units, and solving linear equations with measurements.

## Overview

Measures Calc is a command-line demo of [Swift Measures](/README.md). Evaluate arithmetic expressions, convert between
units, and solve linear equations with one unknown. Calculations across dimensions use composed units, so multiplying
two lengths produces an area and dividing a distance by a duration produces a speed.

## Requirements

These instructions are for macOS and build the demo from source. There is no prebuilt download at present.

- A Mac with macOS 13 or later. Your chosen version of Xcode may require a newer macOS version.
- Swift 6.3 or later and a compatible macOS SDK. The setup below uses Xcode to provide these development tools.
- An internet connection to download the repository and its dependencies.

## Installation

1. Set up the development tools:

   Install [Xcode](https://developer.apple.com/xcode/) from the Mac App Store if you do not already have it. Open Xcode
   and complete its initial setup, including any requested component installation. In **Xcode > Settings > Locations**,
   select your installed Xcode version under **Command Line Tools**. See Apple's
   [Tools Settings](https://developer.apple.com/documentation/xcode/configuring-command-line-tools-settings).

   You do not need to create an Xcode project. The commands below explicitly use Xcode's Swift toolchain so that a
   separately installed Swift compiler does not override it.

2. Open Terminal and check the tools:

   Press **Command-Space**, type **Terminal**, and press **Return**. Terminal lets you run programs by typing commands.
   Copy each command below into that window, press **Return**, and wait for it to finish before entering the next one.
   Keep the same Terminal window open throughout installation.

   ```bash
   xcrun --toolchain XcodeDefault swift --version
   git --version
   ```

   The first command should report Swift 6.3 or later. The second should display a Git version; Git downloads the source
   code in the next step. If either command fails, complete the development-tool setup before continuing. If Swift is
   older than 6.3, install an Xcode version that provides Swift 6.3 or later.

3. Download the repository and open its directory:

   ```bash
   cd "$HOME"
   git clone https://github.com/bikecalc/swift-measures.git
   cd swift-measures
   ```

   This creates a `swift-measures` folder in your home folder. `cd` changes the folder Terminal is working in.
   If you already have a checkout, skip the download and open its repository root instead.

4. Switch to the demo branch, then open the demo directory:

   ```bash
   git switch feature/measures-calc-demo
   cd Demos/MeasuresCalc
   ```

   A branch selects a version of the source code. This branch contains the demo, which uses the Swift Measures package
   in the same checkout. If Git cannot find the branch, see [Troubleshooting](#troubleshooting).

5. Build the executable:

   ```bash
   xcrun --toolchain XcodeDefault swift build -c release --product measures-calc
   ```

   The `xcrun --toolchain XcodeDefault` prefix selects Xcode's matching compiler and SDK for this build. You do not need
   this prefix when running the installed calculator.

   Building turns the source code into a runnable program. The first build downloads dependencies and may take several
   minutes. Wait for `Build complete!` and for the command prompt to return before continuing. If the build fails, see
   [Troubleshooting](#troubleshooting).

6. Install the executable in your user account:

   ```bash
   mkdir -p "$HOME/.local/bin"
   install -m 755 .build/release/measures-calc "$HOME/.local/bin/measures-calc"
   ```

   These commands create a folder for your command-line programs and copy the executable into it. `$HOME` means your
   home folder. Successful installation normally produces no output and does not require an administrator password.

7. Make the command available from any folder:

   For zsh, the default macOS shell, run these commands once:

   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
   source "$HOME/.zshrc"
   ```

   `PATH` is the list of folders Terminal searches for programs. The first command saves this setting for future
   sessions; the second applies it to the current session. Successful execution normally produces no output.
   Skip this step if `~/.local/bin` is already on your `PATH`. If you use another shell, add the equivalent setting to
   that shell's startup file.

8. Verify the installation:

   ```bash
   measures-calc --help
   ```

   You should see help text beginning with an overview of the calculator, followed by its arguments and options.
   The command is now ready to use from any directory, including in a new Terminal window.

After changing or updating the source code, return to `Demos/MeasuresCalc` and repeat the build and install steps to
update the installed executable.

## Demonstration

Enter each command in Terminal and press **Return**. Lines beginning with `# Prints` show the expected result; you do
not need to type those lines.

Put the expression first, in quotes, followed by any options. Quotes prevent the shell from interpreting spaces,
parentheses, or operators. Use `measures-calc --list-units` to see the supported unit symbols.

- Evaluate an arithmetic expression:

  ```bash
  measures-calc "2 + 3 * 4"
  # Prints "14.0"
  ```

- Multiply lengths expressed in different units:

  ```bash
  measures-calc "2 m * 300 cm"
  # Prints "6.0 m²"
  ```

- Convert a speed to another unit:

  ```bash
  measures-calc "36 km/h" --convert-to "m/s"
  # Prints "10.0 m·s⁻¹"
  ```

- Raise a measurement to an integer power:

  ```bash
  measures-calc "(2 m)^3"
  # Prints "8.0 m³"
  ```

  Powers apply to the preceding number, unit, or parenthesized expression: `2 m^2` means two square meters, whereas
  `(2 m)^2` means four square meters. Signed superscripts, such as `m·s⁻²`, are also accepted.

- Solve a linear equation and select the output unit:

  ```bash
  measures-calc "2 * x + 30 cm = 1 m" --solve "x" --convert-to "cm"
  # Prints "x = 35.0 cm"
  ```

## Limitations

- The registry includes all predefined composable units, including metric prefixes. Symbols are case-sensitive; unit
  names such as `meter` are not accepted. Memory and cadence are not supported. Use `--list-units` to view symbols.
- Symbols shared by multiple definitions are rejected as ambiguous.
- Compound symbols such as `km/h` are parsed as arithmetic. Use parentheses when raising a whole compound unit, such
  as `(km/h)^2`; `km/h^2` raises only the hour unit.
- Values use `Double`, so floating-point rounding may appear in the output. Formatting uses a decimal point without
  grouping separators. Commas and underscores in input group integer digits; they are not decimal separators.
- Powers must be integers from -64 through 64. Resulting dimension exponents are restricted to the same range.
- The solver supports linear equations with one unknown. Multiple unknowns, unknowns in denominators, and nonlinear
  equations are unsupported.
- Temperature expressions support conversion constants, but equations containing offset units such as Celsius or
  Fahrenheit are unsupported. Express those equations in kelvin instead. Temperature differences are not modeled
  separately from absolute temperatures.
- Non-finite results are reported as errors. Physical valid ranges are not enforced or clamped.

## Troubleshooting

### Demo Branch Not Found

The demo branch must be published to GitHub before a fresh clone can use it. If `git switch feature/measures-calc-demo`
fails in an existing checkout, run `git fetch origin` and try again. If it still fails, confirm that the branch is
available in the repository. These instructions cannot download unpublished local work.

### Swift Toolchain and SDK Mismatch

If building reports `Invalid manifest`, `unknown argument: '-target-arch-variant'`, or a compiler crash, check which
Swift toolchain is selected. A separately installed toolchain may be incompatible with the SDK supplied by Xcode.

The installation steps explicitly select Xcode's toolchain to avoid this mismatch. If you used plain `swift build`,
repeat the build from the demo directory with:

```bash
xcrun --toolchain XcodeDefault swift build -c release --product measures-calc
```

Xcode's toolchain must also satisfy the Swift 6.3 requirement. Once the build succeeds, continue with the installation
steps. Toolchain selection is only needed for building; the installed `measures-calc` command runs directly.

### Command Not Found

If the shell cannot find `measures-calc`, confirm that you completed the installation and `PATH` steps. Open a new
terminal or reload your shell configuration. You can also check the installation directly:

```bash
"$HOME/.local/bin/measures-calc" --help
```

### Expressions Beginning with a Minus Sign

Quotes protect an expression from the shell, but the argument parser can still interpret a leading minus sign as an
option. Wrap the expression in parentheses inside the quotes so that it starts with `(`. Keep the expression first,
followed by any options:

```bash
measures-calc "(-2 m)" --convert-to "cm"
# Prints "-200.0 cm"
```

## Uninstallation

Remove the installed executable:

```bash
rm "$HOME/.local/bin/measures-calc"
```

If you added `~/.local/bin` to your `PATH` solely for this demo and no other commands use it, you can also remove the
corresponding `export PATH` line from `~/.zshrc`. Open a new terminal after updating your shell configuration.

## Contributing

Everyone is welcome to contribute to Measures. See the [Contributing](/CONTRIBUTING.md) guide to get started.

If you find a bug, please create an [issue](https://github.com/bikecalc/swift-measures/issues). Security vulnerabilities
should be reported using the instructions in the [Security Policy](/SECURITY.md).

## Code of Conduct

This project follows a [Code of Conduct](/CODE_OF_CONDUCT.md).

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the [License](/LICENSE.md) for more
information.
