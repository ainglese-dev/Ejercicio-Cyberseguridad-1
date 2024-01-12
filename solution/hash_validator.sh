#!/bin/bash

# Define the directory where the files are located
subdir="../source_files"

# Define the file hashes in an associative array
declare -A file_hashes=(
  ["copia.sh"]="90965b0eb20e68b7d0b59accd2a3b4fd"
  ["log.txt"]="0b29406e348cd5f17c2fd7b47b1012f9"
  ["pass.txt"]="6d5e43a730490d75968279b6adbd79ec"
  ["plan-A.txt"]="129ea0c67567301df1e1088c9069b946"
  ["plan-B.txt"]="4e9878b1c28daf4305f17af5537f062a"
  ["script.py"]="66bb9ec43660194bc066bd8b4d35b151"
)

# Function to compare the hash of a file with a given variable
compare_hash() {
  file="$1"
  expected_hash="$2"

  actual_hash=$(md5sum "$file" | awk '{print $1}')

  if [ "$actual_hash" == "$expected_hash" ]; then
    result="Match"
  else
    result="Mismatch"
  fi

  echo "{ \"file\": \"$file\", \"expected_hash\": \"$expected_hash\", \"actual_hash\": \"$actual_hash\", \"result\": \"$result\" }"
}

# Loop through the associative array and compare each file hash
echo "["

first=true
for file in "${!file_hashes[@]}"; do
  if [ "$first" = false ]; then
    echo ","
  else
    first=false
  fi

  filepath="$subdir/$file"
  hash="${file_hashes[$file]}"
  
  compare_result=$(compare_hash "$filepath" "$hash")
  echo -n "$compare_result"
done

echo "]"
