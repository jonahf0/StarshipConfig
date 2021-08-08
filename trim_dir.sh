#!/bin/bash

arr_of_parents=()
split_pwd=""


not_in_home() {
	for dir in $(pwd | rg -o "/([aA-zZ]|_|-|[0-9])*") ; do 
		arr_of_parents+=($dir)
	done
}

in_home() {
	for dir in $(pwd | sed "s/\/home\/$USER/~/g" | rg -o "/([aA-zZ]|_|-|[0-9])*|~") ; do
		arr_of_parents+=($dir)
	done
}


trim_dir() {

	if [[ $(pwd | rg -o "/home/$USER") ]] ; then
		in_home
	else
		not_in_home
	fi
	
	for i in $(seq 0 "$1"); do
		split_pwd+="${arr_of_parents[$i]}"	
	done       

	echo ${split_pwd[*]}

}

trim_dir $1
