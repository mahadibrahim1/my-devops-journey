#!/bin/bash

# This script checks if a file exists and reports its permissions
# Usage: ./file_check.sh filename

# Check if a filename was provided as an argument
if [ $# -eq 0 ]; then
    echo "Error: No filename provided."
    echo "Usage: $0 filename"
    exit 1
fi

# Store the filename from the first argument
filename="$1"

# Check if the file exists
if [ -e "$filename" ]; then
    echo "The file '$filename' exists."
    
    # Check if the file is readable
    if [ -r "$filename" ]; then
        echo "The file is readable."
    else
        echo "The file is not readable."
    fi
    
    # Check if the file is writable
    if [ -w "$filename" ]; then
        echo "The file is writable."
    else
        echo "The file is not writable."
    fi
    
    # Check if the file is executable
    if [ -x "$filename" ]; then
        echo "The file is executable."
    else
        echo "The file is not executable."
    fi
    
    # Additional useful information about the file
    echo -e "\nAdditional file information:"
    
    # Check if it's a regular file or a directory
    if [ -f "$filename" ]; then
        echo "This is a regular file."
    elif [ -d "$filename" ]; then
        echo "This is a directory."
    elif [ -L "$filename" ]; then
        echo "This is a symbolic link."
    fi
    
    # Display file size and last modification time
    echo "File size: $(du -h "$filename" | cut -f1)"
    echo "Last modified: $(stat -c '%y' "$filename" 2>/dev/null || ls -l "$filename" | awk '{print $6, $7, $8}')"
    
else
    echo "The file '$filename' does not exist."
fi
