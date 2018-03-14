# The head of the program, show the program information
BEGIN {
	system ( "clear" )
	print "----------------------------------------"
	print "Program : Detect Process of the cluster"
	print "Author  : LiChun(gengyuntuo@163.com)"
	print "Create  : 2018-03-13 09:30:00"
	print "Describe: Nothing to describe."
	print "----------------------------------------"
	print ""
	print "Starting ...... "
	
	# Inital
	count = 0
	online = 0
	off_line = 0
	nonrecognition=0
	field_numb = 5
}

# The Body of the program
/^[^#]/ {
    # Pre
    count++

    # Work
    if ( NF != field_numb ) {
        nonrecognition++
        print ( "ERROR [" NR "]: Contains " NF " fields, not " field_numb " fields." )
    } else {
        return_code = system( "test \"" $4 "\" = `ssh " $2 "@" $1 " ps -ef | grep " $3 " | grep -v grep | wc -l` && exit 0 || exit 1" )
        if ( return_code == 0) {
            online++
            print ( "OK    [" NR "]: (" $1 ":" $2 ") " $5 )
        } else {
            off_line++
            print ( "NOT OK[" NR "]: (" $1 ":" $2 ") " $5 )
        }
    }
}

# The end of the program, show the result of the program
END {
	print ""
	print "----------------------------------------"
	print "The program is over"
	print "Online Process  : " online
	print "Off-line Process: " off_line
	print "Not Recognized  : " nonrecognition
	print "Total           : " count
	print "----------------------------------------"
}
