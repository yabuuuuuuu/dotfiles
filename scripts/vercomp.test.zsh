#!/usr/bin/env zsh

source "./vercomp.zsh"

testvercomp () {
    vercomp $1 $2
    case $? in
        0 ) op='=';;
        1 ) op='>';;
        2 ) op='<';;
    esac
    if [[ $op != $3 ]]
    then
        echo "FAIL: Expected '$3', Actual '$op', Arg1 '$1', Arg2 '$2'"
    else
        echo "Pass: '$1 $op $2'"
    fi
}

echo "The following tests should pass"
testvercomp "1"            "1"            "="
testvercomp "2.1"          "2.2"          "<"
testvercomp "3.0.4.10"     "3.0.4.2"      ">"
testvercomp "4.08"         "4.08.01"      "<"
testvercomp "3.2.1.9.8144" "3.2"          ">"
testvercomp "3.2"          "3.2.1.9.8144" "<"
testvercomp "1.2"          "2.1"          "<"
testvercomp "2.1"          "1.2"          ">"
testvercomp "5.6.7"        "5.6.7"        "="
testvercomp "1.01.1"       "1.1.1"        "="
testvercomp "1.1.1"        "1.01.1"       "="
testvercomp "1"            "1.0"          "="
testvercomp "1.0"          "1"            "="
testvercomp "1.0.2.0"      "1.0.2"        "="
testvercomp "1..0"         "1.0"          "="
testvercomp "1.0"          "1..0"         "="

echo "The following test should fail (test the tester)"
testvercomp "1" "1" ">"
