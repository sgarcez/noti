#!/bin/sh


docker exec -it noti_db_1 pg_dump postgresql://noti:iton@localhost:5432/noti_local \
    --schema-only -t deals -t places > schema.sql