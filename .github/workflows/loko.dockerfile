
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - loko/**/Dockerfile

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
        name: Build and push schemers/loko:head
        id: docker_build_loko:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: loko:head/
          tags: |
            loko:head
            loko:head-bullseye-slim
      -
        name: Build and push schemers/loko:0
        id: docker_build_loko:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: loko:0/
          tags: |
            loko:0
            loko:0-bullseye-slim
            loko:latest
