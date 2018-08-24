#!/bin/bash

# An interactive script that allows you to delete multiple remote branches from
# a git repository with confirmation before deletion.
#
# Provide the path to the git repo as an argument to the script or it will
# prompt you for the path to the repo
#
# @version 0.1
# @author Evan Reeves <develop@evanreeves.com>
#

if [ ! $# == 1 ]; then
  echo -n "No path provided. Enter path to git repository: "
  read GITPATH
else
  GITPATH=$1
fi

if [ ! -d $GITPATH ]; then
  echo "'$GITPATH' does not exist"
    exit 0
  fi

cd $GITPATH

set -o noglob

BRANCHES=()
# Remove origin/HEAD and ''
let ctr=0
for i in `git branch`; do
  i=`echo "$i" | sed 's/^ *//g' `
  if [[ ! $i =~ HEAD ]] && [[ ! $i =~ '->' ]]; then
    BRANCHES=( "${BRANCHES[@]}" $i)
  fi
  let ctr++
done

run=true
while( $run ); do
  let ctr=1
  while [ $ctr -le ${#BRANCHES[@]} ]; do
    echo "$ctr. ${BRANCHES[$ctr-1]}"
    let ctr++
  done

  echo -n "Enter number of branch(es) to delete (enter Q to quit): "
  read -a remove
  echo ""

  if [ ${remove[0]} = "Q" ] || [ ${remove[0]} = "q" ]; then
    exit 0
  fi

  let ctr=1
  for i in ${remove[@]}; do
    echo "$ctr. ${BRANCHES[$i-1]}"
    let ctr++
  done

  echo -n "Really delete the these branches? [Y/n]: "
  read confirm
  echo ""

  if [ $confirm = "Y" ] || [ $confirm = "y" ]; then
    for i in ${remove[@]}; do
      cmd=`echo ${BRANCHES[$i-1]} | awk '{print "git branch -D "$1}'`
      echo $cmd
      echo $cmd | /bin/sh
      unset BRANCHES[$i-1]
    done
    echo ""
  fi
  BRANCHES=( "${BRANCHES[@]}" )
done
