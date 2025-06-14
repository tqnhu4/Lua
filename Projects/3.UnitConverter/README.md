# Lua Simple Unit Converter CLI Application

A straightforward command-line interface (CLI) application for converting values between various units. It's built in Lua and uses a simple lookup table for conversion rules, making it easy to extend.

## Features
- Diverse Unit Conversions: Supports common conversions like kilometers to miles, Celsius to Fahrenheit, kilograms to pounds, and more.

- Factor-based Conversions: Handles direct multiplicative conversions (e.g., distance, weight).

- Formula-based Conversions: Manages conversions that require specific formulas (e.g., temperature).

- Interactive Mode: Use the converter continuously in an interactive terminal session.

- Single Conversion Mode: Perform a quick, one-off conversion directly from command-line arguments.

- Extensible Conversion Rules: Easily add new unit types and conversion pairs by modifying the CONVERSION_RULES table.

- Help Message: Provides a list of supported units and examples.

- Robust Error Handling: Offers informative messages for unrecognized units, invalid input, or incompatible conversions.

## Prerequisites
To run this application, you need to have Lua installed on your system.

- Install Lua:

  - Ubuntu/Debian: sudo apt-get install lua5.3 (or lua for default version)

  - macOS (using Homebrew): brew install lua

  - Windows: Download from Lua for Windows or use a package manager like Chocolatey (choco install lua).

## How to Run

```text
lua converter.lua
```
### Example:
```text
lua converter.lua 10 km miles
# Output: 10.0000 km is 6.2137 miles

lua converter.lua 25 C F
# Output: 25.0000 C is 77.0000 F

lua converter.lua 100 meters feet
# Output: 100.0000 meters is 328.0840 feet
```
