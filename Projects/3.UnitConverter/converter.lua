-- converter.lua

-- Define conversion rules using a lookup table
-- Each entry is a type of conversion (e.g., "distance", "temperature")
-- Inside each type, define unit pairs and their conversion functions/factors
local CONVERSION_RULES = {
    -- Distance Conversions
    distance = {
        -- km <-> miles
        { from = "km", to = "miles", factor = 0.621371 },
        { from = "miles", to = "km", factor = 1.60934 },
        -- meters <-> feet
        { from = "meters", to = "feet", factor = 3.28084 },
        { from = "feet", to = "meters", factor = 0.3048 },
        -- cm <-> inches
        { from = "cm", to = "inches", factor = 0.393701 },
        { from = "inches", to = "cm", factor = 2.54 }
    },
    -- Temperature Conversions (require formulas, not just factors)
    temperature = {
        -- Celsius <-> Fahrenheit
        { from = "C", to = "F", func = function(c) return (c * 9/5) + 32 end },
        { from = "F", to = "C", func = function(f) return (f - 32) * 5/9 end }
    },
    -- Weight/Mass Conversions
    weight = {
        -- kg <-> lbs
        { from = "kg", to = "lbs", factor = 2.20462 },
        { from = "lbs", to = "kg", factor = 0.453592 },
        -- grams <-> ounces
        { from = "grams", to = "ounces", factor = 0.035274 },
        { from = "ounces", to = "grams", factor = 28.3495 }
    }
    -- Add more conversion types and units as needed
}

-- Function to find a conversion rule
-- Returns the rule table if found, otherwise nil
local function find_conversion_rule(from_unit, to_unit)
    for _, type_rules in pairs(CONVERSION_RULES) do
        for _, rule in ipairs(type_rules) do
            if rule.from == from_unit and rule.to == to_unit then
                return rule
            end
        end
    end
    return nil
end

-- Function to get compatible units for a given unit
-- Used for suggesting valid conversions
local function get_compatible_units(unit)
    local compatible = {}
    for conv_type, type_rules in pairs(CONVERSION_RULES) do
        for _, rule in ipairs(type_rules) do
            if rule.from == unit then
                table.insert(compatible, rule.to)
            elseif rule.to == unit then
                table.insert(compatible, rule.from)
            end
        end
    end
    -- Remove duplicates
    local seen = {}
    local unique_compatible = {}
    for _, u in ipairs(compatible) do
        if not seen[u] then
            seen[u] = true
            table.insert(unique_compatible, u)
        end
    end
    return unique_compatible
end

-- Function to perform the conversion
local function convert(value, from_unit, to_unit)
    local rule = find_conversion_rule(from_unit, to_unit)

    if not rule then
        -- Check for reverse conversion
        rule = find_conversion_rule(to_unit, from_unit)
        if rule then
            -- If reverse rule found, apply the inverse operation
            if rule.func then
                -- For functions, we can't simply invert them easily without explicit inverse function
                -- This case would require defining inverse functions in the rules
                return nil, string.format("Error: Direct conversion from '%s' to '%s' not found. Temperature conversions require explicit inverse definitions.", from_unit, to_unit)
            else
                -- For factor-based conversions, just divide by the factor
                return value / rule.factor
            end
        else
            local compatible_from = table.concat(get_compatible_units(from_unit), ", ")
            local compatible_to = table.concat(get_compatible_units(to_unit), ", ")

            if #compatible_from > 0 and #compatible_to == 0 then
                return nil, string.format("Error: Cannot convert from '%s' to '%s'. '%s' can be converted to: %s. '%s' is not a recognized unit.", from_unit, to_unit, from_unit, compatible_from, to_unit)
            elseif #compatible_from == 0 and #compatible_to > 0 then
                return nil, string.format("Error: Cannot convert from '%s' to '%s'. '%s' is not a recognized unit. '%s' can be converted from: %s.", from_unit, to_unit, from_unit, to_unit, compatible_to)
            elseif #compatible_from > 0 and #compatible_to > 0 then
                 return nil, string.format("Error: Incompatible units: '%s' and '%s'. Please check your units.", from_unit, to_unit)
            else
                return nil, string.format("Error: Units '%s' and '%s' are not recognized or no direct conversion rule exists.", from_unit, to_unit)
            end
        end
    end

    if rule.func then
        return rule.func(value)
    elseif rule.factor then
        return value * rule.factor
    end
end

-- Function to display help message
local function show_help()
    print("Usage: lua converter.lua <value> <from_unit> <to_unit>")
    print("       lua converter.lua (for interactive mode)")
    print("")
    print("Supported Units:")
    for conv_type, type_rules in pairs(CONVERSION_RULES) do
        print(string.format("  -- %s --", conv_type:gsub("^%l", string.upper)))
        local units_in_type = {}
        for _, rule in ipairs(type_rules) do
            if not table.concat(units_in_type, ", "):find(rule.from) then
                table.insert(units_in_type, rule.from)
            end
            if not table.concat(units_in_type, ", "):find(rule.to) then
                table.insert(units_in_type, rule.to)
            end
        end
        table.sort(units_in_type)
        print("    " .. table.concat(units_in_type, ", "))
    end
    print("")
    print("Examples:")
    print("  lua converter.lua 10 km miles")
    print("  lua converter.lua 25 C F")
    print("  lua converter.lua 100 meters feet")
    print("  lua converter.lua 50 lbs kg")
end

-- Main execution block
local args = {...} -- Get command line arguments

-- Command-line mode
if #args == 3 then
    local value_str = args[1]
    local from_unit = string.lower(args[2])
    local to_unit = string.lower(args[3])

    local value = tonumber(value_str)
    if not value then
        print("Error: Invalid value. Please provide a number.")
        show_help()
        os.exit(1)
    end

    local result, err = convert(value, from_unit, to_unit)

    if result then
        print(string.format("%.4f %s is %.4f %s", value, from_unit, result, to_unit))
    else
        print(err)
        os.exit(1)
    end

-- Interactive mode or help
else
    if #args > 0 then -- If arguments exist but not 3, assume it's a malformed call or help request
        show_help()
        os.exit(1)
    end

    -- Interactive Mode
    print("--- Lua Unit Converter (Interactive Mode) ---")
    print("Type 'help' for usage, 'exit' to quit.")
    print("")

    while true do
        io.write("Enter conversion (e.g., '10 km miles'): ")
        local input = io.read()
        print("") -- Add a newline for better formatting

        if string.lower(input) == "exit" then
            print("Exiting converter.")
            break
        elseif string.lower(input) == "help" then
            show_help()
        else
            local parts = {}
            for s in string.gmatch(input, "%S+") do -- Split input by whitespace
                table.insert(parts, s)
            end

            if #parts == 3 then
                local value_str = parts[1]
                local from_unit = string.lower(parts[2])
                local to_unit = string.lower(parts[3])

                local value = tonumber(value_str)
                if not value then
                    print("Error: Invalid value. Please provide a number.")
                else
                    local result, err = convert(value, from_unit, to_unit)
                    if result then
                        print(string.format("%.4f %s is %.4f %s", value, from_unit, result, to_unit))
                    else
                        print(err)
                    end
                end
            else
                print("Error: Invalid input format. Use 'value from_unit to_unit' or 'help'.")
            end
        end
    end
end