#!/usr/bin/env sh

for stage in DEV
do
    echo ${stage}
    make update \
        STAGE=${stage} \
        AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
        AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
        AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
done
