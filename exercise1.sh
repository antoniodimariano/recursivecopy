#!/bin/bash

function checkBeforeRemove() {
	

		read -p " Do you whish to create the directory  `pwd`/$1 ? " yn
		case $yn in 
			[Yy]* ) 
				mkdir `pwd`/$1
				return 1
				;;
			[Nn]* ) 
				exit;;
			* ) 
				echo "Please answer yes or no";;
		esac	
	
}
#check parameters

if [ $# -lt 2 ]
then
	echo "Usage: $0 source-dir dest-dir"
	exit 1
fi

if [ ! -d $2 ]
then
	echo  Not a directory
	checkBeforeRemove $2
	
fi
if [ ! -d $1 ]
then
	echo  Not a directory
	checkBeforeRemove $1
	
fi


#controllare passaggio paramentro 
if [ $# -gt 2 ]
then 
		if [ $3 == "-w" ]
		then
			echo "You are overwritting " $2

		else
			echo "Illegal parameter"
			exit 1
		fi
fi




cd $1
for file in `find .`
do
	if [ "$file" == "." ]
	then 
		continue
	fi

	if [ -d $file ]
	then 
		if [ -e ../$2/$file ]
		then
			rm -rf ../$2/$file
		fi
		mkdir ../$2/$file
	else
		t="./"
		#echo ${file/$t/}

		filename=${file/$t/}
		#data_cut=${file#"./"}
		#echo "After Replacement:" ${file//.//$file}
		cp -v $filename   ../$2/$filename
	fi
done
cd ..
list="ls -la $2"
echo "*--`pwd`/$2 --*"

eval $list