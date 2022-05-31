FROM golang:1.16

RUN apt-get update && apt-get install -y jq docker.io docker-compose
