#!/bin/bash

# This script demonstrates basic file and directory operations in Bash
# It performs the following steps:
#   1. Creates a new directory
#   2. Changes into that directory
#   3. Creates a new file
#   4. Writes text to the file
#   5. Displays the contents of the file

# Define variables for better readability and maintenance
DIR_NAME="my_new_directory"
FILE_NAME="sample.txt"

# Step 1: Create a new directory
echo "Creating directory: $DIR_NAME"
mkdir -p "$DIR_NAME"

# Step 2: Navigate into the directory
echo "Changing to directory: $DIR_NAME"
cd "$DIR_NAME"

# Step 3: Create a new file in the directory
echo "Creating file: $FILE_NAME"
touch "$FILE_NAME"

# Step 4: Write some text to the file
echo "Writing content to file: $FILE_NAME"
echo "Hello, world!" > "$FILE_NAME"
echo "This file was created by a Bash script." >> "$FILE_NAME"
echo "Current date and time: $(date)" >> "$FILE_NAME"

# Step 5: Display the contents of the file
echo -e "\nDisplaying contents of $FILE_NAME:"
cat "$FILE_NAME"

# Print the current working directory to confirm location
echo -e "\nCurrent working directory: $(pwd)"

