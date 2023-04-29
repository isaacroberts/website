#!/bin/bash
source ~/.bash_profile
shopt -s expand_aliases



# Commit
git add .
git commit -m "$1"
echo "committed"
git push --progress
echo "pushed"

notify
