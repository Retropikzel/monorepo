
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - mosh/**/Dockerfile

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v2
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Login to DockerHub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Build and push schemers/mosh:head
        id: docker_build_mosh:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: mosh:head/
          tags: |
            mosh:head
            mosh:head-bullseye-slim
      -
        name: Build and push schemers/mosh:0
        id: docker_build_mosh:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: mosh:0/
          tags: |
            mosh:0
            mosh:0-bullseye-slim
            mosh:latest
