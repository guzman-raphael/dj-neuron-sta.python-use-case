#!/usr/bin/env bash

TYPE="UI"

DIRNAME=$(cd . ; pwd )

main() {
  # clean
  # build
  # load
  run
}

clean() {
  sudo rm -r $DIRNAME/client/config/movie-data
  sudo rm -r $DIRNAME/client/config/neuron-data
  sudo rm $DIRNAME/client/log/*
}

run() {
  # Run
  docker-compose up
}

load() {
  # Load
  docker stop $(docker ps -q)
  docker system prune -fa && docker volume prune -f
  docker load < $DIRNAME"/"$TYPE"_DJCLIENT.tar.gz"

}

build() {
  # Min Build (Unpacked: 199MB, Packed: 83MB, Build Time: 5min)
  # UI Build (Unpacked: 406MB, Packed: 193MB, Build Time: 11min)
  # Official Pull/Build (Unpacked: 1.2GB, Packed: 509MB, Pull/Build Time: 4.5min)
  time (
    docker stop $(docker ps -q)
    docker container prune -f
    # docker system prune -fa && docker volume prune -f
    docker-compose build
    rm $DIRNAME"/"$TYPE"_DJCLIENT.tar.gz"
    docker save dj_client:v1.0 | gzip > $DIRNAME"/"$TYPE"_DJCLIENT.tar.gz"
  )
}

main
