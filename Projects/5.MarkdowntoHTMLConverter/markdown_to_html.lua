-- markdown_to_html.lua

-- A simple Markdown to HTML converter.
-- Supports H1-H6 headers and paragraphs.
-- Useful for learning string processing and regular expressions in Lua.

local function markdown_to_html(markdown_text)
    local html_lines = {}
    local lines = {}

    -- Split the input markdown text into individual lines.
    -- This handles both Unix-style (\n) and Windows-style (\r\n) newlines.
    for line in markdown_text:gmatch("([^\r\n]*)\r?\n?") do
        table.insert(lines, line)
    end

    local in_paragraph = false -- Flag to track if we are currently inside a <p> tag

    for _, line in ipairs(lines) do
        -- Trim leading and trailing whitespace from the line for cleaner parsing.
        local trimmed_line = line:match("^%s*(.-)%s*$")

        if trimmed_line == "" then
            -- If it's an empty line, it breaks any current paragraph.
            if in_paragraph then
                table.insert(html_lines, "</p>") -- Close the paragraph tag
                in_paragraph = false
            end
            -- Skip adding empty lines to the HTML output directly,
            -- as they are implicitly handled by closing/opening paragraphs.
        else
            -- Check for Headers (H1 to H6)
            local header_level = 0
            -- Iterate from H6 down to H1 to correctly match specific header levels.
            -- Example: '## Header' should match H2, not just H1 (if the pattern was generic).
            for i = 6, 1, -1 do
                -- Pattern for a header: '#' repeated 'i' times, followed by a space, then content.
                local pattern = string.rep("#", i) .. " (.*)"
                local content = trimmed_line:match(pattern)
                if content then
                    header_level = i
                    -- If we were in a paragraph, close it before adding a header.
                    if in_paragraph then
                        table.insert(html_lines, "</p>")
                        in_paragraph = false
                    end
                    -- Add the HTML header tag.
                    table.insert(html_lines, string.format("<h%d>%s</h%d>", header_level, content, header_level))
                    break -- Found a header, stop checking and move to the next line.
                end
            end

            -- If the line was not identified as a header:
            if header_level == 0 then
                -- If we are not currently in a paragraph, start a new one.
                if not in_paragraph then
                    table.insert(html_lines, "<p>")
                    in_paragraph = true
                end
                -- Add the trimmed line content to the HTML output.
                table.insert(html_lines, trimmed_line)
            end
        end
    end

    -- After processing all lines, if a paragraph was left open, close it.
    if in_paragraph then
        table.insert(html_lines, "</p>")
    end

    -- Join all generated HTML lines with newlines.
    return table.concat(html_lines, "\n")
end

-- Main execution block: Handles command-line arguments for file input/output.
local args = {...} -- Get command-line arguments

-- Show usage instructions if no arguments are provided.
if #args == 0 then
    print("Usage: lua markdown_to_html.lua <input_markdown_file> [output_html_file]")
    print("       (If no output_html_file, the HTML will be printed to the console.)")
    print("")
    print("Example:")
    print("  lua markdown_to_html.lua input.md output.html")
    print("  lua markdown_to_html.lua my_document.md")
    os.exit(1)
end

local input_file_path = args[1]
local output_file_path = args[2] -- Optional output file

-- Open and read the input Markdown file.
local input_file = io.open(input_file_path, "r")
if not input_file then
    print(string.format("Error: Could not open input file '%s'.", input_file_path))
    os.exit(1)
end
local markdown_content = input_file:read("*a") -- Read the entire file content
io.close(input_file)

-- Perform the conversion.
local html_content = markdown_to_html(markdown_content)

-- Write the converted HTML to an output file or print to console.
if output_file_path then
    local output_file = io.open(output_file_path, "w")
    if not output_file then
        print(string.format("Error: Could not open output file '%s' for writing.", output_file_path))
        os.exit(1)
    end
    output_file:write(html_content)
    io.close(output_file)
    print(string.format("Successfully converted '%s' to '%s'.", input_file_path, output_file_path))
else
    -- If no output file is specified, print to console.
    print("--- Converted HTML ---")
    print(html_content)
    print("----------------------")
end