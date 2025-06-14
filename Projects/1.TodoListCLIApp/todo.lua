-- todo.lua

local JSON = (loadstring or load) [[
  -- A simple JSON parser/encoder for Lua
  -- Supports basic types, tables, and nested structures.
  -- Does NOT support numbers with exponents or other advanced JSON features.

  local M = {}

  local function is_array(t)
    local i = 1
    for _ in pairs(t) do
      if t[i] == nil then return false end
      i = i + 1
    end
    return true
  end

  local function encode_string(s)
    s = s:gsub("\\", "\\\\")
    s = s:gsub("\"", "\\\"")
    s = s:gsub("\n", "\\n")
    s = s:gsub("\r", "\\r")
    s = s:gsub("\t", "\\t")
    return '"' .. s .. '"'
  end

  function M.encode(value)
    if type(value) == "number" or type(value) == "boolean" then
      return tostring(value)
    elseif type(value) == "string" then
      return encode_string(value)
    elseif type(value) == "table" then
      local parts = {}
      if is_array(value) then
        for _, v in ipairs(value) do
          table.insert(parts, M.encode(v))
        end
        return "[" .. table.concat(parts, ",") .. "]"
      else
        for k, v in pairs(value) do
          table.insert(parts, encode_string(k) .. ":" .. M.encode(v))
        end
        return "{" .. table.concat(parts, ",") .. "}"
      end
    elseif value == nil then
      return "null"
    else
      error("Unsupported type for JSON encoding: " .. type(value))
    end
  end

  function M.decode(json_string)
    -- Basic parser, not fully robust for all JSON valid cases.
    -- Uses Lua's built-in load/string.format for parsing simplicity.
    local func, err = load("return " .. json_string:gsub("true", "true"):gsub("false", "false"):gsub("null", "nil"))
    if not func then error("JSON parsing error: " .. err) end
    return func()
  end

  return M
]]() -- End of JSON module

local FILE_NAME = "tasks.json"

local cjson = require("cjson")

-- Function to load tasks from the JSON file
local function load_tasks()
    local file = io.open(FILE_NAME, "r")
    if file then
        local content = file:read("*a")
        io.close(file)
        
        if content == "" then -- Handle empty file case
            return {}
        end
        
        --local success, tasks = pcall(JSON.decode, content)

        local tasks = cjson.decode(content)
        --if success then
        if tasks then
            return tasks
        else
            print("Error decoding tasks from file. Starting with an empty list.")
            return {}
        end
    else
        return {} -- Return empty table if file doesn't exist
    end
end

-- Function to save tasks to the JSON file
local function save_tasks(tasks)
    local file = io.open(FILE_NAME, "w")
    if file then
        local success, encoded_tasks = pcall(JSON.encode, tasks)
        if success then
            file:write(encoded_tasks)
            io.close(file)
            return true
        else
            io.close(file)
            print("Error encoding tasks to JSON: " .. encoded_tasks)
            return false
        end
    else
        print("Error: Could not open file for writing.")
        return false
    end
end

-- Function to add a new task
local function add_task(description)
    local tasks = load_tasks()
    local new_id = 1
    if #tasks > 0 then
        -- Find the maximum ID and increment it for a new unique ID
        for _, task in ipairs(tasks) do
            if task.id and task.id >= new_id then
                new_id = task.id + 1
            end
        end
    end

    local new_task = {
        id = new_id,
        description = description,
        completed = false
    }
    table.insert(tasks, new_task)
    if save_tasks(tasks) then
        print(string.format("Task #%d added: '%s'", new_task.id, new_task.description))
    end
end

-- Function to list all tasks
local function list_tasks()
    
    local tasks = load_tasks()
    
    if #tasks == 0 then
        print("No tasks found. Add one with 'add <description>'.")
        return
    end

    print("--- Your Todo List ---")
    for _, task in ipairs(tasks) do
        local status = task.completed and "[X]" or "[ ]"
        print(string.format("%s %d. %s", status, task.id, task.description))
    end
    print("----------------------")
end

-- Function to mark a task as complete
local function complete_task(task_id_str)
    local tasks = load_tasks()
    local task_id = tonumber(task_id_str)
    if not task_id then
        print("Error: Invalid task ID. Please provide a number.")
        return
    end

    local found = false
    for _, task in ipairs(tasks) do
        if task.id == task_id then
            task.completed = true
            found = true
            print(string.format("Task #%d marked as complete.", task_id))
            break
        end
    end

    if not found then
        print(string.format("Error: Task #%d not found.", task_id))
    else
        save_tasks(tasks)
    end
end

-- Function to delete a task
local function delete_task(task_id_str)
    local tasks = load_tasks()
    local task_id = tonumber(task_id_str)
    if not task_id then
        print("Error: Invalid task ID. Please provide a number.")
        return
    end

    local initial_count = #tasks
    for i = #tasks, 1, -1 do -- Iterate backwards to safely remove elements
        if tasks[i].id == task_id then
            table.remove(tasks, i)
            print(string.format("Task #%d deleted.", task_id))
            break
        end
    end

    if #tasks == initial_count then
        print(string.format("Error: Task #%d not found.", task_id))
    else
        save_tasks(tasks)
    end
end

-- Function to clear all tasks
local function clear_all_tasks()
    local confirm = io.read("Are you sure you want to clear all tasks? (yes/no): ")
    if string.lower(string.gsub(confirm, "%s", "")) == "yes" then
        if save_tasks({}) then
            print("All tasks cleared.")
        end
    else
        print("Operation cancelled.")
    end
end

-- Function to display help message
local function show_help()
    print("Usage: lua todo.lua <command> [arguments]")
    print("")
    print("Commands:")
    print("  add <description>     Add a new task.")
    print("  list                  List all tasks.")
    print("  complete <id>         Mark a task as completed by its ID.")
    print("  delete <id>           Delete a task by its ID.")
    print("  clear                 Clear all tasks.")
    print("  help                  Show this help message.")
    print("")
    print("Examples:")
    print("  lua todo.lua add \"Buy groceries\"")
    print("  lua todo.lua list")
    print("  lua todo.lua complete 1")
    print("  lua todo.lua delete 2")
    print("  lua todo.lua clear")
end

-- Main execution block
local args = {...} -- Get command line arguments

if #args == 0 then
    show_help()
    os.exit(1)
end

local command = args[1]

if command == "add" then
    if #args < 2 then
        print("Error: 'add' command requires a description.")
        show_help()
    else
        -- Join all arguments after the command as the description
        local description = table.concat(args, " ", 2)
        add_task(description)
    end
elseif command == "list" then
    list_tasks()
elseif command == "complete" then
    if #args < 2 then
        print("Error: 'complete' command requires a task ID.")
        show_help()
    else
        complete_task(args[2])
    end
elseif command == "delete" then
    if #args < 2 then
        print("Error: 'delete' command requires a task ID.")
        show_help()
    else
        delete_task(args[2])
    end
elseif command == "clear" then
    clear_all_tasks()
elseif command == "help" then
    show_help()
else
    print("Error: Unknown command '" .. command .. "'.")
    show_help()
    os.exit(1)
end
