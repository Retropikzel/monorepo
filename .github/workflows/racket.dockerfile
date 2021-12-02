
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - racket/**/Dockerfile

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
        name: Build and push schemers/racket:6
        id: docker_build_racket:6
        uses: docker/build-push-action@v2
        with:
          push: true
          context: racket:6/
          tags: |
            racket:6
            racket:6-bullseye-slim
            racket:latest
