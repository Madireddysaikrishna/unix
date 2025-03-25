#!/bin/bash

echo "Welcome to the Guessing Game!"
echo "Select difficulty level:"
echo "1. Easy (7 tries)"
echo "2. Medium (5 tries)"
echo "3. Hard (3 tries)"
read -p "Enter your choice (1/2/3): " difficulty

# Set number of allowed attempts based on difficulty
case $difficulty in
    1) max_attempts=7 ;;
    2) max_attempts=5 ;;
    3) max_attempts=3 ;;
    *) echo "Invalid choice, defaulting to Medium (5 tries)"; max_attempts=5 ;;
esac

random_number=$(( RANDOM % 10 + 1 ))  # Generates a random number between 1 and 10
attempts=0
score=$((max_attempts * 10))  # Initial score, decreases with each attempt

echo "Guess a number between 1 and 10. You have $max_attempts attempts."

while [ $attempts -lt $max_attempts ]; do
    read -p "Enter your guess: " guess
    ((attempts++))
    ((score -= 10))  # Decrease score with each attempt

    if [ "$guess" -eq "$random_number" ]; then
        echo "🎉 Congratulations! You guessed the correct number in $attempts attempts!"
        echo "Your score: $score"
        exit 0
    elif [ "$guess" -lt "$random_number" ]; then
        if [ $((random_number - guess)) -eq 1 ]; then
            echo "You're very close! 🔥 Try a bit higher."
        else
            echo "Too low! Try again."
        fi
    else
        if [ $((guess - random_number)) -eq 1 ]; then
            echo "You're very close! 🔥 Try a bit lower."
        else
            echo "Too high! Try again."
        fi
    fi

    echo "Attempts remaining: $((max_attempts - attempts))"
done

echo "💀 Game Over! The correct number was $random_number."
echo "Your final score: $score"
