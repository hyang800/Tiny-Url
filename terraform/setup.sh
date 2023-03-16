#!/bin/sh
set -x
logfile=/tmp/userdata.debug
exec > $logfile 2>&1
mkdir tinyurl
mkdir tinyurl/templates
aws s3 cp s3://hyang800/app.py tinyurl/app.py
aws s3 cp s3://hyang800/init_db.py tinyurl/init_db.py
aws s3 cp s3://hyang800/schema.sql tinyurl/schema.sql
aws s3 cp s3://hyang800/base.html tinyurl/templates/base.html
aws s3 cp s3://hyang800/data.html tinyurl/templates/data.html
aws s3 cp s3://hyang800/index.html tinyurl/templates/index.html
cd tinyurl
python init_db.py
pip3 install hashids
pip3 install flask
flask run --host=0.0.0.0