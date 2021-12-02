
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - tinyscheme/**/Dockerfile

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
        name: Build and push schemers/tinyscheme:1
        id: docker_build_tinyscheme:1
        uses: docker/build-push-action@v2
        with:
          push: true
          context: tinyscheme:1/
          tags: |
            tinyscheme:1
            tinyscheme:1-bullseye-slim
            tinyscheme:latest
