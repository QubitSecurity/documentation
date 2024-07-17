##qcow2, xml 파일 파일명IP에 따른 짝/홀 분리
#!/bin/bash

# 폴더 경로를 입력받습니다.
read -p "directory path: " directory

# 폴더 내의 파일명을 추출합니다.
file_list=$(ls "$directory")

mkdir "$directory/server1"
mkdir "$directory/server2"

# 추출한 파일들을 순회하며 이동합니다.
for file in $file_list
do
        #echo "$file"
        extension="${file##*.}"
        #echo "$extension"
        if [ "$extension" = "xml" ]||[ "$extension" = "qcow2" ]; then
                extracted_string=${file:1:5}
                if [[ "$extracted_string" =~ ^[0-9]+$ ]]; then
                        count=$((extracted_string%2))
                        echo "$count"
                        if [ $count -eq 1 ]; then
                                cp "$file" "$directory/server1"

                        elif [ $count -eq 0 ]; then
                                cp "$file" "$directory/server2"
                        fi
                        count=0
                else
                        continue
                fi
        fi
done
