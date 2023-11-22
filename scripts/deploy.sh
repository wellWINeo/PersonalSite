#!/bin/sh

source .env

ARCHIVE=website.tar.gz

tar -zcvf $ARCHIVE \
    --exclude="scripts/*" \
    --exclude="scripts" \
    --exclude=".gitignore" \
    --exclude=".DS_Store" \
    --exclude-vcs \
    --no-mac-metadata \
    ./*

scp $ARCHIVE $DEPLOY_USER@$DEPLOY_SERVER:~/Downloads
ssh $DEPLOY_USER@$DEPLOY_SERVER -t -C "sudo tar -zxvf ~/Downloads/$ARCHIVE -C $WWW_ROOT && rm ~/Downloads/$ARCHIVE"

rm $ARCHIVE