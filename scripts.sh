#!/bin/bash

# Client
function build_client_dev() {
  docker build \
    -f ./client/Dockerfile.dev \
    -t betancourtl/complex-client ./client
}

function run_client_dev() {
  docker run \
    --rm \
    -p 3000:3000 \
    -v '/app/node_modules' \
    -v "$(pwd)/client/:/app" \
    betancourtl/complex-client
}

# Server
function build_server_dev() {
  docker build \
    -f ./server/Dockerfile.dev \
    -t betancourtl/complex-server ./server
}

function run_server_dev() {
  docker run \
    --rm \
    -p 5000:5000 \
    -v '/app/node_modules' \
    -v "$(pwd)/server/:/app" \
    betancourtl/complex-server
}

function build_worker_dev() {
  docker build \
    -f ./worker/Dockerfile.dev \
    -t betancourtl/complex-worker ./worker
}

function run_worker_dev() {
  docker run \
    --rm \
    -v '/app/node_modules' \
    -v "$(pwd)/worker/:/app" \
    betancourtl/complex-worker
}

function run() {
  trap "kill 0" EXIT
  run_client_dev &
  run_server_dev &
  run_worker_dev &
  wait
}

"$@"
