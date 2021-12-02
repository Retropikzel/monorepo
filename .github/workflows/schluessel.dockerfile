
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - schluessel/**/Dockerfile

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
        name: Build and push schemers/schluessel:0
        id: docker_build_schluessel:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: schluessel:0/
          tags: |
            schluessel:0
            schluessel:0-bullseye-slim
            schluessel:latest
