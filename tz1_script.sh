#!/bin/bash

input_dir="$1"
output_dir="$2"

# Проверяем существование входной директории
if [ ! -d "$input_dir" ]; then
    echo "'$input_dir' not found"
    exit 1
fi

# Проверяем существование выходной директории
if [ ! -d "$output_dir" ]; then
    echo "'$output_dir' not found"
fi
# Идем по всем файлам в директории
k=0
find "$input_dir" -type f | while read -r file; do

    file_name=$(basename -- "$file")
    base_name="${file_name%.*}"
    extension="${file_name##*.}"

    # Если нашли файл с повторяющимся названием:
    if [ -e "$output_dir/$file_name" ]; then
        ((k+=1))
        file_name="${base_name}_${k}.${extension}"
    fi

    # Копируем файл в выходную директорию
    cp "$file" "$output_dir/$file_name"
    k=0
done

echo "Файлы перекопированы"