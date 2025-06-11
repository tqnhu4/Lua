# 🚀 7-Day Lua Learning Roadmap
This roadmap is designed to give you a solid foundation in Lua programming within seven days, combining theoretical concepts with practical code examples. Let's dive in!

## 📅 Day 1: The Absolute Basics - Hello World & Variables
Goal: Understand Lua's syntax for comments, printing, and defining basic variables.

- Concepts:

  - Installation/Setup: How to run Lua scripts.
  - print() function: Outputting to the console.
  - Comments: Single-line (--) and multi-line (--[[ ... --]]).
  - Variables: Global variables (default), local variables (local), and common data types (nil, boolean, number, string).
  - Arithmetic and Comparison Operators.
- Example Code:

```lua
-- Day 1: Basics

-- Hello World!
print("Hello, Lua!")

-- Single-line comment

--[[
  Multi-line comment
  This code demonstrates basic concepts.
--]]

-- Variables and Data Types
local myNumber = 10
local myString = "Lua is fun!"
local myBoolean = true
local myNil = nil -- Represents the absence of a value

print("Number:", myNumber)
print("String:", myString)
print("Boolean:", myBoolean)
print("Nil value:", myNil) -- Output will be 'nil'

-- Arithmetic Operations
local a = 5
local b = 2
print("Addition:", a + b)     -- 7
print("Subtraction:", a - b)  -- 3
print("Multiplication:", a * b) -- 10
print("Division:", a / b)     -- 2.5 (floating-point division)
print("Floor Division:", a // b) -- 2 (integer division)
print("Modulo:", a % b)       -- 1
print("Exponentiation:", a ^ b) -- 25 (5 to the power of 2)

-- Comparison Operators
print("Equal:", a == b)           -- false
print("Not Equal:", a ~= b)        -- true (or != in some contexts/engines, but ~= is standard Lua)
print("Greater Than:", a > b)     -- true
print("Less Than:", a < b)        -- false
print("Greater or Equal:", a >= b) -- true
print("Less or Equal:", a <= b)   -- false
```


- Practice:

  - ✍️ Write scripts to calculate simple math problems.
  - 🔬 Experiment with different data types.

### 🚦 Day 2: Control Structures - Decisions and Loops
- Goal: Learn how to control the flow of your program based on conditions and repeat actions.

- Concepts:

  - if, elseif, else: Conditional execution.
  - while loop: Loop as long as a condition is true.
  - repeat...until loop: Loop at least once until a condition is true.
  - for loop: Numeric for loop (for i = start, end, step do).
  - break and continue (or goto for similar effect).
- Example Code:  

```lua
-- Day 2: Control Structures

-- If-Elseif-Else
local score = 85
if score >= 90 then
    print("Grade: A")
elseif score >= 80 then
    print("Grade: B")
else
    print("Grade: C or lower")
end

-- While Loop
local count = 1
while count <= 5 do
    print("While loop iteration:", count)
    count = count + 1
end

-- Repeat-Until Loop
local num = 1
repeat
    print("Repeat-until loop iteration:", num)
    num = num + 1
until num > 5

-- Numeric For Loop
for i = 1, 5, 1 do -- start, end, step (step defaults to 1)
    print("For loop iteration:", i)
end

for i = 10, 1, -2 do -- Counting down with a step
    print("Countdown:", i)
end

-- Break in loop
local found = false
for i = 1, 10 do
    if i == 7 then
        print("Found 7! Breaking loop.")
        found = true
        break
    end
    print("Checking:", i)
end
if found then
    print("Loop finished early.")
end
```

- Practice:

  - 🎲 Create a simple guessing game using if and while loops.
  - ✖️ Generate a multiplication table using a for loop.

### 🧩 Day 3: Functions - Reusability and Organization
- Goal: Understand how to define and use functions to organize your code and promote reusability.

- Concepts:

  - Function Definition: function function_name(...) ... end.
  - Parameters and Return Values: Single and multiple return values.
  - Variadic Functions: ... for variable arguments.
  - Local Functions: Scope considerations.
  - First-Class Functions: Functions can be assigned to variables, passed as arguments, and returned from other functions.
- Example Code:  

```lua
-- Day 3: Functions

-- Basic function definition
function greet(name)
    print("Hello,", name .. "!")
end

greet("Alice")
greet("Bob")

-- Function with return value(s)
function add(x, y)
    return x + y
end

local sum = add(5, 3)
print("Sum:", sum)

function getMinMax(a, b)
    if a < b then
        return a, b -- Returns multiple values
    else
        return b, a
    end
end

local minVal, maxVal = getMinMax(10, 7)
print("Min:", minVal, "Max:", maxVal)

-- Variadic Function
function sumAll(...)
    local total = 0
    -- '...' acts like an array of arguments, but it's not a true table.
    -- We can convert it to a table using { ... }
    for _, val in ipairs({ ... }) do
        total = total + val
    end
    return total
end

print("Sum of all:", sumAll(1, 2, 3, 4, 5))
print("Sum of some:", sumAll(10, 20))

-- Local Function (preferred for encapsulation)
local function calculateArea(width, height)
    return width * height
end

print("Area:", calculateArea(4, 5))
```

- Practice:

  - 🌡️ Write functions to perform common calculations (e.g., Fahrenheit to Celsius).
  - 📊 Create a function that takes a list of numbers and returns their average.

### 📚 Day 4: Tables - Lua's Powerful Data Structure
- Goal: Master tables, Lua's only built-in data structure, which can act as arrays, dictionaries, and objects.

- Concepts:

  - Table Creation: {}, {[key]=value}.
  - Array-like Tables: Numeric indices starting from 1.
  - Dictionary-like Tables: String or number keys.
  - Mixed Tables: Combining array and dictionary parts.
  - Table Operations: table.insert(), table.remove(), table.sort(), table.concat().
  - Generic For Loop (for key, value in pairs(table) do).
  - Numeric For Loop for arrays (for index, value in ipairs(table) do).
- Example Code:  

```lua
-- Day 4: Tables

-- Empty table
local myTable = {}

-- Array-like table (implicit numeric keys starting from 1)
local fruits = {"apple", "banana", "cherry"}
print("First fruit:", fruits[1])
print("Second fruit:", fruits[2])

-- Dictionary-like table (explicit keys)
local person = {
    name = "John Doe",
    age = 30,
    city = "New York"
}
print("Person's name:", person.name) -- Access using dot notation
print("Person's age:", person["age"]) -- Access using bracket notation

-- Mixed table
local mixedData = {
    "first_item", -- index 1
    "second_item", -- index 2
    name = "Mixed",
    id = 123
}
print("Mixed item 1:", mixedData[1])
print("Mixed name:", mixedData.name)

-- Adding and removing elements
table.insert(fruits, "date") -- Adds to the end
print("Fruits after insert:", table.concat(fruits, ", "))

table.remove(fruits, 2) -- Removes "banana" (index 2)
print("Fruits after remove:", table.concat(fruits, ", "))

-- Iterating tables
print("Iterating dictionary-like table:")
for key, value in pairs(person) do
    print(key, ":", value)
end

print("Iterating array-like table (ipairs - ordered):")
for index, value in ipairs(fruits) do -- ipairs is for integer keys, guaranteed order
    print(index, ":", value)
end

-- Nested tables
local users = {
    {name = "Alice", email = "alice@example.com"},
    {name = "Bob", email = "bob@example.com"}
}
print("First user's email:", users[1].email)
```


- Practice:

  - 📦 Create a table to store inventory items (name, quantity, price).
  - 🔍 Write functions to add, remove, and find items in your inventory table.


### ⚙️ Day 5: Modules and Metatables - Advanced Concepts
- Goal: Understand how to organize larger Lua projects using modules and explore the power of metatables for object-oriented programming (OOP) and custom behavior.

- Concepts:

  - Modules (require, module pattern): How to create and use separate files for code organization.
  - Metatables and Metamethods: Customizing behavior for tables (e.g., arithmetic operations, indexing).
  - __index: Implementing inheritance/lookup.
  - __newindex: Controlling assignment to table elements.
  - __call: Making tables callable.
Basic OOP Simulation: Using tables and metatables to simulate classes and objects.
- Example Code:

my_module.lua:  

```lua
-- my_module.lua
local M = {} -- Convention to store module functions/data

local private_var = "I am private!" -- Not accessible from outside

function M.public_function(name)
    print("Hello from module, " .. name .. "!")
    print("Accessing private:", private_var)
end

function M.add(a, b)
    return a + b
end

return M -- Return the module table
```

main.lua:

```lua
-- Day 5: Modules and Metatables

-- Using a Module
local myModule = require("my_module") -- 'my_module.lua' must be in Lua's path or current directory

myModule.public_function("World")
print("Module addition:", myModule.add(10, 5))

-- Metatables and Metamethods (OOP Simulation)

-- A "class" definition
local Account = {}
Account.__index = Account -- When a key is not found in an Account instance, look it up in Account table itself

-- Constructor
function Account.new(balance)
    local self = {balance = balance or 0}
    setmetatable(self, Account) -- Set Account as the metatable for 'self'
    return self
end

function Account:deposit(amount)
    self.balance = self.balance + amount
    print("Deposited", amount .. ". New balance:", self.balance)
end

function Account:withdraw(amount)
    if self.balance >= amount then
        self.balance = self.balance - amount
        print("Withdrew", amount .. ". New balance:", self.balance)
    else
        print("Insufficient funds.")
    end
end

-- Example usage
local acc1 = Account.new(100)
acc1:deposit(50) -- Shorthand for Account.deposit(acc1, 50)
acc1:withdraw(30)
acc1:withdraw(200)

local acc2 = Account.new(500)
print("Acc2 balance:", acc2.balance)

-- Metamethods for arithmetic operations (e.g., for vector/matrix libraries)
local Vector = {}
Vector.__add = function(v1, v2)
    return {x = v1.x + v2.x, y = v1.y + v2.y}
end

local vec1 = {x = 1, y = 2}
local vec2 = {x = 3, y = 4}

setmetatable(vec1, Vector)
setmetatable(vec2, Vector)

local vec3 = vec1 + vec2 -- Uses the __add metamethod
print("Vector sum:", vec3.x, vec3.y) -- Output: 4 6
```


- Practice:

  - ➕ Create a simple math_utils module with functions like factorial, power, etc.
  - 🧑‍🤝‍🧑 Implement a basic Person class using metatables with new and sayHello methods.

### 📂 Day 6: File I/O and Standard Libraries
- Goal: Learn how to interact with the file system and utilize common built-in Lua libraries.

- Concepts:

  - File I/O (io library): Reading from and writing to files.
  - io.open(), file:read(), file:write(), file:close().
  - io.lines(), io.input(), io.output().
  - String Manipulation (string library): string.len(), string.sub(), string.find(), string.gsub(), string.format().
  - Math Functions (math library): math.abs(), math.sqrt(), math.random(), math.floor(), math.ceil().
  - OS Library (os library): os.time(), os.date(), os.execute(), os.remove(), os.rename().
- Example Code:  

```lua
-- Day 6: File I/O and Standard Libraries

-- File I/O
local filename = "my_data.txt"

-- Write to a file
local file, err = io.open(filename, "w") -- "w" for write, "a" for append
if file then
    file:write("Hello from Lua!\n")
    file:write("This is a test file.\n")
    file:close()
    print("Data written to", filename)
else
    print("Error writing file:", err)
end

-- Read from a file
local file_read, err_read = io.open(filename, "r") -- "r" for read
if file_read then
    local content = file_read:read("*all") -- Read entire file
    print("Content of", filename .. ":\n" .. content)
    file_read:close()

    -- Read line by line
    print("Reading line by line:")
    for line in io.lines(filename) do -- Automatically opens and closes file
        print(line)
    end
else
    print("Error reading file:", err_read)
end

-- String Library
local text = "Lua programming is awesome!"
print("Length:", string.len(text))
print("Substring:", string.sub(text, 5, 15)) -- "programmin"
print("Find 'is':", string.find(text, "is")) -- Start and end index
print("Replace 'awesome' with 'great':", string.gsub(text, "awesome", "great"))
print("Formatted string:", string.format("The value is %.2f", 123.4567))

-- Math Library
print("Absolute value of -5:", math.abs(-5))
print("Square root of 16:", math.sqrt(16))
math.randomseed(os.time()) -- Seed the random number generator
print("Random number (0-1):", math.random())
print("Random integer (1-10):", math.random(1, 10))
print("Floor of 3.7:", math.floor(3.7))
print("Ceil of 3.2:", math.ceil(3.2))

-- OS Library
print("Current time (timestamp):", os.time())
print("Current date and time:", os.date()) -- Default format
print("Formatted date:", os.date("%A, %B %d, %Y")) -- Custom format

-- Clean up: remove the created file
-- os.remove(filename)
-- print("Removed", filename)
```

- Practice:

  - 📝 Create a script that reads a list of names from a file, shuffles them, and writes the shuffled list to a new file.
  - 🛠️ Write a simple command-line tool that takes a string and prints its length and reversed version.


### 🐞 Day 7: Error Handling, Debugging, and Further Exploration
- Goal: Understand how to handle errors gracefully, basic debugging techniques, and where to go next.

- Concepts:

  - Error Handling (pcall, xpcall): Protected calls to catch errors.
  - assert(): Checking conditions and throwing errors.
  - Debugging: Simple print statements, understanding stack traces.
  - Coroutines (coroutine library): Cooperative multitasking (advanced).
  - C API (brief mention): Extending Lua with C/C++.
  - Ecosystem: LuaRocks (package manager), specific engines/frameworks (e.g., LÖVE2D, OpenResty, Roblox, Defold).
- Example Code:  

```lua
-- Day 7: Error Handling, Debugging, and Further Exploration

-- Error Handling with pcall
function divide(a, b)
    if b == 0 then
        error("Division by zero is not allowed!") -- Throws an error
    end
    return a / b
end

print("\n--- pcall example ---")
local status, result = pcall(divide, 10, 2)
if status then
    print("Division successful:", result)
else
    print("Division failed:", result) -- result contains the error message
end

local status2, result2 = pcall(divide, 10, 0)
if status2 then
    print("Division successful:", result2)
else
    print("Division failed:", result2)
end

-- Assert
print("\n--- assert example ---")
local value = 10
assert(value > 5, "Value must be greater than 5") -- No error
print("Assertion 1 passed.")

-- assert(value < 5, "Value must be less than 5") -- This will cause an error and stop execution

-- Debugging (simple print statements)
print("\n--- Debugging example ---")
local x = 10
print("Debug: x =", x)
local y = x * 2
print("Debug: y =", y)
local z = y + 5
print("Final result:", z)

-- Coroutines (brief example, more complex in real use)
print("\n--- Coroutine example ---")
local co = coroutine.create(function(val)
    print("Coroutine started with:", val)
    coroutine.yield(val + 1) -- Pause and yield a value
    print("Coroutine resumed.")
    coroutine.yield(val + 2)
    return "Finished"
end)

print("Main: Resuming coroutine 1")
print("Coroutine yielded:", coroutine.resume(co, 10)) -- Start/resume, pass 10 to coroutine

print("Main: Resuming coroutine 2")
print("Coroutine yielded:", coroutine.resume(co)) -- Resume again

print("Main: Resuming coroutine 3")
local status_co, result_co = coroutine.resume(co) -- Resume for final return
print("Coroutine finished:", result_co)
print("Coroutine status:", coroutine.status(co)) -- Should be "dead"
```


- Practice:

  - ⚠️ Modify previous functions to use pcall for robust error handling.
  - ✅ Experiment with assert for input validation.


This 7-day roadmap provides a structured approach to learning Lua. Remember to practice consistently, experiment with the code, and apply what you've learned to small projects. The best way to learn is by doing!

What specific areas or types of projects are you most interested in exploring with Lua? Knowing that might help guide your next steps!  