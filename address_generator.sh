#!/bin/bash
# Specify the directory where executable files are located
root_directory="/home/isec/Documents/model/nano"

# Specify the Python script you want to run
python_script="/home/isec/Documents/model/getAddress.py"

json_str=".tgcfi.json"

readDir() {
  local dir=$1
  local files=$(ls "$dir")
  #echo $dir
  for file in $files; do
    local path="$dir/$file"
    #echo $path
    if [ -d "$path" ]; then
      readDir "$path"
    else
      local json_path="$path$json_str"
      if [ -e "$json_path" ]; then
        echo "Running $python_script for $path"
        python3 "$python_script" "$path"
      fi
    fi
  done
}

readDir "$root_directory"