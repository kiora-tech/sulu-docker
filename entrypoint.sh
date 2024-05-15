#!/bin/sh

PROJECT_NAME=${1:-my-sulu-project}

composer create-project sulu/skeleton $PROJECT_NAME

chown -R $UID:$GID $PROJECT_NAME
