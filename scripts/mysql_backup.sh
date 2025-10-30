#!/bin/bash
DATE=$(date +%F)
mysqldump -u root -pYOURPASSWORD --all-databases > /home/ubuntu/mysql-backup-$DATE.sql
echo "Backup completed: /home/ubuntu/mysql-backup-$DATE.sql"
