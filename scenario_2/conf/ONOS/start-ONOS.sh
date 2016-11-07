#!/bin/bash

# Load bashrc
PS1='$ ' . ~/.bashrc

cd $KARAF_ROOT; ./bin/start
