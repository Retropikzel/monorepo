
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - picrin/**/Dockerfile

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
        name: Build and push schemers/picrin:head
        id: docker_build_picrin:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: picrin:head/
          tags: |
            picrin:head
            picrin:head-bullseye-slim
      -
        name: Build and push schemers/picrin:0
        id: docker_build_picrin:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: picrin:0/
          tags: |
            picrin:0
            picrin:0-bullseye-slim
            picrin:latest
