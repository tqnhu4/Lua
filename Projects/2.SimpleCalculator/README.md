# Lua Simple Calculator CLI Application
A command-line interface (CLI) calculator application written in Lua, capable of evaluating basic arithmetic operations and complex expressions.

## Features
- Basic Operations: Supports addition (+), subtraction (-), multiplication (*), and division (/).

- Complex Expressions: Evaluates expressions with multiple operations and parentheses, respecting standard order of operations.

- Interactive Mode: Run the calculator in an interactive session for continuous calculations.

- Single Expression Mode: Evaluate a single expression directly from command-line arguments.

- Error Handling: Provides feedback for syntax errors or runtime issues (e.g., division by zero).


## Prerequisites
To run this application, you need to have Lua installed on your system.

- Install Lua:

  - Ubuntu/Debian: sudo apt-get install lua5.3 (or lua for default version)

  - macOS (using Homebrew): brew install lua

  - Windows: Download from Lua for Windows or use a package manager like Chocolatey (choco install lua).

## How to Run
- Save the Code: Save the provided Lua code into a file named calculator.lua.

- Open Terminal/Command Prompt: Navigate to the directory where you saved calculator.lua.

- Execute the Calculator:

  ### Interactive Mode
  Run the script without any arguments to enter an interactive session. You can type expressions one by one. Type exit to quit.

  ```text
  lua calculator.lua
  ```

  ### Example Interactive Session:
  ```text
    Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): 10 + 5 * 2
    Result: 20.0
    Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): (10 + 5) * 2
    Result: 30.0
    Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): 10 / 0
    Runtime error: attempt to divide by zero
    Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): exit
    Exiting calculator.
  ```

  ### Single Expression Mode
    Provide the mathematical expression directly as command-line arguments. For expressions containing spaces or parentheses, enclose the entire expression in quotes (single or double).  

```text
lua calculator.lua "10 + 5"
# Output: Result: 15.0

lua calculator.lua "(20 / 4) - 2 * 3"
# Output: Result: -1.0

lua calculator.lua "5 + (10 - 2) * 3 / 2"
# Output: Result: 17.0
```

## How It Works
The calculator leverages Lua's powerful load() function. This function dynamically compiles and executes a given string as a Lua chunk. By prepending "return " to your mathematical expression, the load() function creates a callable function that, when executed, returns the result of that expression.

Lua's built-in parser inherently handles operator precedence (e.g., multiplication/division before addition/subtraction) and parentheses, eliminating the need for a complex custom parsing algorithm.

