#!/usr/bin/env bash
set -ex
CERT_FOLDER=$2
SUBJECT=$1
IPS=$3
DNSS=$4
EXPIRY=$5

CLIENT_CERT_FOLDER=$CERT_FOLDER/client
SERVER_CERT_FOLDER=$CERT_FOLDER/server

mkdir -p $CLIENT_CERT_FOLDER
mkdir -p $SERVER_CERT_FOLDER

SUBJECT=$SUBJECT CLIENT_CERT_FOLDER=$CLIENT_CERT_FOLDER EXPIRY=$EXPIRY docker-compose build

SUBJECT=$SUBJECT CLIENT_CERT_FOLDER=$CLIENT_CERT_FOLDER EXPIRY=$EXPIRY docker-compose up client-certificator
cp $CLIENT_CERT_FOLDER/ca.pem $SERVER_CERT_FOLDER
SUBJECT=$SUBJECT CLIENT_CERT_FOLDER=$CLIENT_CERT_FOLDER SERVER_CERT_FOLDER=$SERVER_CERT_FOLDER IPS=$IPS DNSS=$DNSS EXPIRY=$EXPIRY docker-compose up server-certificator


