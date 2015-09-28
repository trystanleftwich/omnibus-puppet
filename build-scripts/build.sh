#!/bin/bash

PROJECT_PATH=$1
PROJECT_NAME=$2

cd $PROJECT_PATH

export PATH=/usr/local/bin:$PATH

bundle install --binstubs 
bin/omnibus build $PROJECT_NAME
