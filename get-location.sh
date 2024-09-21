#!/bin/bash

script_path=$(readlink -f "$0") # получаем путь к исполняемому файлу
script_dir=$(dirname "$script_path") # получаем путь к директории исполняемого файла

python_venv=$script_dir/venv/bin/python
script=$script_dir/geo-location.py

$python_venv "$script"

exit 0