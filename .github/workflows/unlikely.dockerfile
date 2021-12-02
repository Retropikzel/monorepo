
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - unlikely/**/Dockerfile

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
        name: Build and push schemers/unlikely:head
        id: docker_build_unlikely:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: unlikely:head/
          tags: |
            unlikely:head
            unlikely:head-bullseye-slim
            unlikely:latest
