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


# check if -w options has been inserted  
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


#main 
destination_path=`pwd`/$2
cd $1
echo "destination path saved : " $destination_path

for file in `find .`
do
	if [ "$file" == "." ]
	then 
		continue
	fi

	if [ -d $file ]
	then 
		if [ -e $destination_path/$file ]
		then
			rm -rf $destination_path/$file
		fi
		mkdir $destination_path/$file
	else
		t="./"
		#remove ./ 	
		filename=${file/$t/}
		cp -v $filename   $destination_path/$filename
	fi
done

cd ..
list="ls -la $destination_path"
echo "*--$destination_path --*"

eval $list