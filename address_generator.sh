#!/bin/bash

# Specify the directory where executable files are located
root_directory="/path/to/parent/directory"

# Specify the Python script you want to run
python_script="/path/to/your/python/script.py"

# Find all executable files in all subdirectories
executables=$(find "$root_directory" -type f -executable)

# Loop through each executable and run the Python script under its folder
for executable in $executables; do
    executable_directory=$(dirname "$executable")
    echo "Running $python_script for $executable in $executable_directory"
    cd "$executable_directory" || exit
    python3 "$python_script" "$executable"
    cd - || exit
done