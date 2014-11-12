#!/bin/sh
option=0

echo 'Welcome!'
while [ $option -ne 4 ]
do
    echo 'Please select an option:'
    echo '1. Ancestry history' 
    echo '2. Who is online'
    echo '3. What process any user is running'
    echo '4. Exit'
    read option

    case $option in
	1) echo
	    echo 'The Process Ancestry Tree Is...'
	    ps -ef > psfile.txt
	    cpid=$(awk '$8=="ps"{print $2}' psfile.txt)
	    ppid=$(awk '$8=="ps"{print $3}' psfile.txt)
	    echo $cpid

	    while [ $cpid -ne 1 ]
	    do
		echo ' | '
		cpid=$ppid
		ppid=$(awk -v pid="$cpid" '{if($2==pid)print $3}' psfile.txt)
		echo $cpid
	    done
	    echo
	    ;;

	2) echo
	    who | sort -u -k1,1 | cut -c -6
	    echo
	    ;;

	3) echo
	    echo 'Choose a User:'
	    who | sort -u -k1,1 | cut -c -6 > who.txt
	    awk -v line=1 '{print line, $0
                                    line++}' who.txt
       
	    read user

	    ps -ef > psfile.txt
	    awk -v usr="$user" '{if($1==usr)print $0}' psfile.txt
	    echo
	    ;;

	4) echo
	    ;; 

	*) echo
	    echo 'INVALID OPTION'
	    echo
	    ;;
    esac
done



