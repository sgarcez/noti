#!/bin/bash

docker exec -i noti_db_1 psql postgresql://noti:iton@localhost:5432/noti_local < data.sql