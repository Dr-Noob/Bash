#!/bin/bash
files=$(ls -l | wc -l)
random=$((1 + RANDOM % $files))
echo $(ls | head -$random | tail -1)
