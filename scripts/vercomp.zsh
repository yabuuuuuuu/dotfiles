#!/usr/bin/env zsh

# linux - How to compare two strings in dot separated version format in Bash? - Stack Overflow
# https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash

# 0: == / 1: > / 2: <
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local i ver1=("${(@s/./)1}") ver2=("${(@s/./)2}")
    for ((i=$(( ${#ver1[@]} + 1 )); i<=${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for i in {1..${#ver1}}
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        local v1=$((10#${ver1[i]})) v2=$((10#${ver2[i]}))
        if [[ $v1 -gt $v2 ]]
        then
            return 1
        fi
        if [[ $v1 -lt $v2 ]]
        then
            return 2
        fi
    done
    return 0
}
