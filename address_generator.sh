#!/bin/bash
# Specify the directory where executable files are located
# root_directory="/home/isec/Documents/model/nano"
root_directory="/home/isec/Documents/data2/NeuTyPro-O2-Set-1-01/binaries"

# Specify the Python script you want to run
python_script="/home/isec/Documents/model/getAddress.py"

json_str=".tgcfi.json"
declare -i cnt=0
readDir() {
  local dir=$1
  local files=$(ls "$dir")
  #echo $dir
  for file in $files; do
    if [ file == "json_files" ]; then
        echo "skipping json_files"
        continue
    fi
    local path="$dir/$file"
    #echo $path
    if [ -d "$path" ]; then
      readDir "$path"
    else
      local text_path="$path"
      if [ ! -s "$text_path" ]; then
        echo "$text_path is empty"
        continue
      fi
      local json_path="$path$json_str"
      if [ -e "$json_path" ]; then
        echo "Running $python_script for $path"
        python3 "$python_script" "$path"
        ((cnt++))
      fi
    fi
  done
}

readDir "$root_directory"
echo $cnt