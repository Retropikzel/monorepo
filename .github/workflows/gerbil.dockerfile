
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - gerbil/**/Dockerfile

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
        name: Build and push schemers/gerbil:head
        id: docker_build_gerbil:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: gerbil:head/
          tags: |
            gerbil:head
            gerbil:head-bullseye-slim
      -
        name: Build and push schemers/gerbil:0
        id: docker_build_gerbil:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: gerbil:0/
          tags: |
            gerbil:0
            gerbil:0-bullseye-slim
            gerbil:latest
