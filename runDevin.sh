#!/usr/bin/env bash

# Set environment variables
export SANDBOX_USER_ID=$(id -u)
export PERSIST_SANDBOX="true"
export SSH_PASSWORD="${SSH_PASSWORD:-default_password}"
export WORKSPACE_BASE="${WORKSPACE_BASE:-/default/workspace/path}"

# Run the Docker container
docker run \
    --pull=always \
    -e SANDBOX_USER_ID \
    -e PERSIST_SANDBOX \
    -e SSH_PASSWORD \
    -e WORKSPACE_MOUNT_PATH=$WORKSPACE_BASE \
    -v $WORKSPACE_BASE:/actions-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 3000:3000 \
    --add-host host.docker.internal:host-gateway \
    --name opendevin-app-$(date +%Y%m%d%H%M%S) \
    ghcr.io/opendevin/opendevin:0.6
