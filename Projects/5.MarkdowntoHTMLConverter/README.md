## Lua Markdown to HTML Converter
A straightforward command-line interface (CLI) application written in Lua that converts basic Markdown syntax into HTML. This project serves as an excellent practical example for learning string manipulation and regular expressions in Lua.

## Features
- Header Conversion: Converts Markdown headers (from # for <h1> to ###### for <h6>) into their corresponding HTML header tags.

- Paragraph Conversion: Any line of plain text that is not a header will be wrapped in HTML <p> (paragraph) tags.

- Line-by-Line Parsing: Processes the Markdown content line by line, identifying and converting elements sequentially.

- Whitespace Handling: Trims leading/trailing whitespace from lines.

- File Input/Output: Reads Markdown content from an input file and writes the generated HTML to an output file, or prints it to the console.


## How It Works
- The core of this converter lies in its markdown_to_html function:

- Line Segmentation: The input Markdown text is first split into individual lines, handling various newline conventions (\n, \r\n).

- Header Detection: Each line is checked against regular expressions to identify if it's a Markdown header (e.g., lines starting with one to six # symbols followed by a space). The check is performed from ###### down to # to ensure correct header level matching.

- Paragraph Management: If a line is not a header and not empty, it's treated as part of a paragraph. The parser maintains a state to correctly open and close <p> tags for continuous blocks of text. Empty lines or headers will automatically close any open paragraph tags.

- String Manipulation: Lua's powerful string manipulation functions (string.match, string.rep, string.format) and pattern matching capabilities are used extensively to parse and transform the Markdown syntax into HTML.

## Prerequisites
To run this application, you need to have Lua installed on your system.

- Install Lua:

  - Ubuntu/Debian: sudo apt-get install lua5.3 (or lua for default version)

  - macOS (using Homebrew): brew install lua

  - Windows: Download from Lua for Windows or use a package manager like Chocolatey (choco install lua).

## How to Run
- Save the Code: Save the provided Lua code into a file named markdown_to_html.lua.

- Create a Markdown File: Create a sample Markdown file (e.g., input.md) with some content:  

```text
# My Document Title

This is a paragraph of text. It can span multiple lines.

## A Subheading

Another paragraph here.
It demonstrates how multiple lines
form a single paragraph.

### Sub-subheading

* List item one
* List item two
```

(Note: The current converter only supports headers and basic paragraphs; lists will be treated as paragraphs.)

- Open Terminal/Command Prompt: Navigate to the directory where you saved markdown_to_html.lua and input.md.

- Execute the Converter:

  ### Convert to an Output File
  To convert input.md and save the result to output.html:

  ```text
  lua markdown_to_html.lua input.md output.html
  ```

  This will create output.html in the same directory.

  ### Convert and Print to Console
  To convert input.md and print the resulting HTML directly to your terminal: 

  ```text
  lua markdown_to_html.lua input.md
  ```

  

