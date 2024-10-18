#!/bin/bash 
ls -1  | tr 'a-zA-Z' 'A-Za-z' | tr -d 'aA'

