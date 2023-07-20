#!/bin/bash

Docker run --name fr232d-msql_FRApps-Dev03 -e MYSQL_ROOT_PASSWORD=root -p 3307:3306 -d mysql:latest
