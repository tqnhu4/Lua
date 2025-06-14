-- guess_the_number.lua

-- Seed the random number generator using the current time
math.randomseed(os.time())

-- Function to start and play the game
local function play_game()
    -- Generate a random number between 1 and 100
    local target_number = math.random(1, 100)
    local guess = nil
    local guess_count = 0
    local input_valid = false

    print("--- Guess the Number Game ---")
    print("I'm thinking of a number between 1 and 100.")
    print("Can you guess what it is?")

    -- Game loop
    while guess ~= target_number do
        repeat
            io.write("Enter your guess: ")
            local raw_input = io.read()
            local num_input = tonumber(raw_input)

            if num_input == nil then
                print("Invalid input. Please enter a number.")
                input_valid = false
            elseif num_input < 1 or num_input > 100 then
                print("Number out of range. Please guess between 1 and 100.")
                input_valid = false
            else
                guess = num_input
                input_valid = true
            end
        until input_valid

        guess_count = guess_count + 1

        if guess < target_number then
            print("Too low! Try a higher number.")
        elseif guess > target_number then
            print("Too high! Try a lower number.")
        else
            print(string.format("Congratulations! You guessed the number %d in %d guesses!", target_number, guess_count))
        end
    end

    print("----------------------------")
end

-- Run the game
play_game()