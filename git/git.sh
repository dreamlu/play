#!/bin/bash
cd repository/$1
#mkdir "$1"
#cd "$1"
git init .
git pull $2

