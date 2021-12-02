
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - chicken/**/Dockerfile

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
        name: Build and push schemers/chicken:5.3
        id: docker_build_chicken:5.3
        uses: docker/build-push-action@v2
        with:
          push: true
          context: chicken:5.3/
          tags: |
            chicken:5
            chicken:5.3
            chicken:5-bullseye-slim
            chicken:latest
      -
        name: Build and push schemers/chicken:4.13
        id: docker_build_chicken:4.13
        uses: docker/build-push-action@v2
        with:
          push: true
          context: chicken:4.13/
          tags: |
            chicken:4.13
            chicken:4
