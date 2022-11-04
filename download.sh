#!/bin/bash

DOMAIN="https://pwk.hide01.ir"

#MODULES NUMBER
MAIN_NODE=$(jq '.modules | length' course.json)
MAIN_NODE=$(($MAIN_NODE-1))

#SUBMODULES LENGTH
#sub_module_length=$((jq '.modules[$i].subModules | length' course.json))
#SUBSECTIONS LENGTH
#sub_section_length=$((jq '.modules[$i].subModules[$j] | length' course.json))
echo "Main node length: $MAIN_NODE"

for (( i = 0; i <= $MAIN_NODE; i++ )) 
do
    MODULE=$(jq ".modules[$i].title" course.json -r)
    P=$(jq ".modules[$i].path" course.json -r)
    mkdir -p "$MODULE"
    FULLPATH="$DOMAIN/$P"
    echo "$MODULE + $FULLPATH"
    ######################################################################
    #curl "$FULLPATH" -X 'GET' -o "./$MODULE/$MODULE.mp4"
    ######################################################################
    #SUBMODULES
    SUB_MODULES_LENGTH=$(jq ".modules[$i].subModules | length" course.json)
    SUB_MODULES_LENGTH=$(($SUB_MODULES_LENGTH-1))
    for (( j = 0; j <= $SUB_MODULES_LENGTH; j++ )) 
    do
        SUBMODULE=$(jq ".modules[$i].subModules[$j].title" course.json -r)
        P=$(jq ".modules[$i].subModules[$j].path" course.json -r)
        FULLPATH="$DOMAIN/$P"
        echo "  $SUBMODULE + $FULLPATH"
        ######################################################################
        #curl "$FULLPATH" -X 'GET' -o "./$MODULE/$SUBMODULE.mp4"
        ######################################################################
        SUB_SECTIONS_LENGTH=$(jq ".modules[$i].subModules[$j].subSections | length" course.json)
        SUB_SECTIONS_LENGTH=$(($SUB_SECTIONS_LENGTH-1))
        for (( k = 0; k <= $SUB_SECTIONS_LENGTH; k++ ))
        do
            SUBSECTION=$(jq ".modules[$i].subModules[$j].subSections[$k].title" course.json -r)
            P=$(jq ".modules[$i].subModules[$j].subSections[$k].path" course.json -r)
            FULLPATH="$DOMAIN/$P"
            echo "    |_$SUBSECTION + $FULLPATH"
            ######################################################################
            #curl "$FULLPATH" -X 'GET' -o "./$MODULE/$SUBSECTION.mp4"
            ######################################################################
        done
    done
done