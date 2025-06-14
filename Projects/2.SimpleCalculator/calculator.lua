-- calculator.lua

-- Function to evaluate a mathematical expression
local function evaluate_expression(expression)
    -- Load the expression as a Lua chunk.
    -- The "return" keyword makes it return the result of the expression.
    -- local func, err = load("return " .. expression)
    local func, err = loadstring("return " .. expression)

    if not func then
        -- If loading fails (e.g., syntax error in expression)
        return nil, "Error in expression: " .. err
    end

    -- Execute the loaded function and return its result.
    -- pcall is used to catch runtime errors during execution (e.g., division by zero).
    local success, result = pcall(func)

    if success then
        -- Check if the result is a number, otherwise it's likely an invalid operation
        if type(result) == "number" then
            return result
        else
            return nil, "Error: Expression did not evaluate to a number."
        end
    else
        -- If pcall fails (runtime error)
        return nil, "Runtime error: " .. result -- 'result' here is the error message
    end
end

-- Main execution block
local args = {...} -- Get command line arguments

-- Determine the expression to evaluate
local expression
if #args > 0 then
    -- If arguments are provided, join them to form the expression string
    expression = table.concat(args, " ")
else
    -- If no arguments, prompt the user for input
    io.write("Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): ")
    expression = io.read()
    print("") -- Add a newline for better formatting
end

-- Loop for interactive mode if no initial arguments were given
while true do
    if string.lower(expression) == "exit" and #args == 0 then
        print("Exiting calculator.")
        break
    end

    if expression == "" then
        print("Please enter an expression.")
    else
        local result, err = evaluate_expression(expression)

        if result then
            print("Result: " .. tostring(result))
        else
            print(err)
        end
    end

    -- In interactive mode, prompt for the next expression
    if #args == 0 then
        io.write("Enter an expression (e.g., 5 + 3 * 2 or 'exit' to quit): ")
        expression = io.read()
        print("")
    else
        -- If command-line arguments were provided, only execute once
        break
    end
end