#!/bin/bash

docker run -d --rm -v /home/debian/data:/home/merlyn/data -e S3_PATH=$HOSTNAME -e S3_ID=${S3_ID} -e S3_KEY=${S3_KEY}  switchworks/merlyn-s3:v2.0

sleep 10

timestamp=$(date +%s)

cp /home/debian/testFile /home/debian/data/${timestamp}.pdf

# Uncomment these lines to enable download testing
# curl https://merlyn.switchworks.tech/file --output /home/debian/downloads/test.pdf

# rm /home/debian/downloads/*
