#!/bin/sh
# run script in bg, save script pid in a global var
# 10 May 2008 Arnon Meydav written

init_fork () 
    {
        # Convert script name to a safe form (to use as a variable), without slashes and dots.
        scriptname=`echo $1 | tr -d "/."`
        # Execute script with args in bg:
        $*&
        # Save pid in an identifiable format, by script name
        export pid_${scriptname}=$!
    }

# run script in bg, but in same shell context (source), save script pid in a global var
init_source_fork () {
        # Convert script name to a safe form (to use as a variable), without slashes and dots.
        scriptname=`echo $1 | tr -d "/."`
        # Execute script with args in bg:
        (. $*)& 
        # Save pid in an identifiable format, by script name
        export pid_${scriptname}=$!
}

# Use bash builtin: wait, to wait for process to finish, using saved pid
init_join () 
    {
        scriptname=`echo $1 | tr -d "/."`
        script_pid_var=pid_$scriptname

        # For ash: Get the pid of the process from name
        eval echo \$$script_pid_var > /tmp/joinpid
        script_pid=`cat /tmp/joinpid`

        # For bash (NOT ash), there is a direct method for variable indirection:
        # script_pid=${!script_pid_var}

        wait $script_pid
        return
    }

UNIT_TEST () 
    {
        init_source_fork ./sleeptest.sh 3 
        init_fork echo a b c
        init_join echo
        init_join ./sleeptest.sh
    }

