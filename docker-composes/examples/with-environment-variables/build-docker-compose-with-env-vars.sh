#!/bin/bash
source env.sh; rm -fr docker-compose.yml; envsubst < "docker-compose.template.yml" > "docker-compose.yml"
