#!/bin/bash

check_error() {
    if [ $? -ne 0 ]; then
        echo "Error occurred"
        exit 1
    fi
}

create_table_script=./src/sql/create_table.sql
script_folder_path=./src/sql


echo "Checking for environment variables"
source .env
check_error

if [ -d "$script_folder_path" ]; then
  # Check if the directory is not empty
  if find "$script_folder_path" -maxdepth 0 -empty | read; then
    echo "The folder '$script_folder_path' exists but is empty."
    exit 1
  else
    echo "The folder '$script_folder_path' exists and contains files or subdirectories."
  fi
else
  echo "The folder '$script_folder_path' does not exist."
  exit 1
fi

echo "Creating database..."
mysqladmin --silent --user=$username --password=$password create $database_name
check_error

echo "Creating tables..."
mysql $database_name < $create_table_script
check_error
