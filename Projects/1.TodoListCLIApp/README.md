# Lua Todo List CLI Application

A simple command-line interface (CLI) application for managing your daily tasks, written in Lua. Tasks are stored persistently in a .json file.

## Features
- Add Tasks: Quickly add new tasks with a description.

- List Tasks: View all your tasks, showing their completion status.

- Mark Tasks as Complete: Mark tasks as done using their unique ID.

- Delete Tasks: Remove specific tasks from your list.

- Clear All Tasks: Delete all tasks with a confirmation prompt.

- Persistent Storage: All tasks are saved to tasks.json and loaded automatically.

## Prerequisites
Before running this application, ensure you have Lua installed on your system.

- Install Lua:

  - Ubuntu/Debian: sudo apt-get install lua5.3 (or lua for default version)

  - macOS (using Homebrew): brew install lua

  - Windows: Download from Lua for Windows or use a package manager like Chocolatey (choco install lua).

## How to Run
- Save the Code: Save the provided Lua code into a file named todo.lua.

- Open Terminal/Command Prompt: Navigate to the directory where you saved todo.lua.

- Run Commands: Execute the application using the lua command followed by todo.lua and the desired command.  

  - Install libraries:
```text
sudo apt install luarocks
luarocks install lua-cjson
```

```lua
lua todo.lua

```

## Usage
Here are the commands you can use:

- 1. add <description> - Add a new task
Adds a new task to your todo list. The description can contain spaces if enclosed in quotes.

```lua
lua todo.lua add "Buy groceries for dinner"
lua todo.lua add "Call John about the meeting"
```

- 2. list - List all tasks
Displays all tasks currently in your todo list, showing their ID, status (completed or not), and description.

```lua
lua todo.lua list
```

### Example Output:

```lua
--- Your Todo List ---
[ ] 1. Buy groceries for dinner
[ ] 2. Call John about the meeting
----------------------
```
- 3. complete <id> - Mark a task as completed
Marks the task with the specified ID as completed.

```lua
lua todo.lua complete 1
```

- 4. delete <id> - Delete a task
Removes the task with the specified ID from your todo list.

```lua
lua todo.lua delete 2
```

- 5. clear - Clear all tasks
Prompts for confirmation and then clears all tasks from your list.

```lua

lua todo.lua clear
```
- 6. help - Show help message
Displays the usage instructions and available commands.

```lua
lua todo.lua help
```

### File Structure
- todo.lua: The main application script.

- tasks.json: (Automatically created) This file stores your tasks in JSON format.

```text
├── todo.lua
└── tasks.json  (created automatically upon first task addition)
```



