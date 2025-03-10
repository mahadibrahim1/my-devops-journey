#!/bin/bash

# Check if source directory is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <source_directory> [backup_directory]"
    echo "If backup_directory is not specified, 'backup' will be used."
    exit 1
fi

# Set source directory
SOURCE_DIR="$1"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Set backup directory (default to 'backup' if not specified)
if [ $# -lt 2 ]; then
    BACKUP_DIR="backup"
else
    BACKUP_DIR="$2"
fi

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    
    # Check if directory was created successfully
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create backup directory '$BACKUP_DIR'."
        exit 1
    fi
fi

# Count the number of .txt files in the source directory
TXT_COUNT=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.txt" | wc -l)

if [ $TXT_COUNT -eq 0 ]; then
    echo "No .txt files found in '$SOURCE_DIR'."
    exit 0
fi

# Copy all .txt files from source to backup directory
echo "Copying $TXT_COUNT .txt files from '$SOURCE_DIR' to '$BACKUP_DIR'..."
cp "$SOURCE_DIR"/*.txt "$BACKUP_DIR"/

# Check if copy operation was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Error: Failed to copy some or all files."
    exit 1
fi
