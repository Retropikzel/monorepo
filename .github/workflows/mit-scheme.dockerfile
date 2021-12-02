
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - mit-scheme/**/Dockerfile

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
        name: Build and push schemers/mit-scheme:11
        id: docker_build_mit-scheme:11
        uses: docker/build-push-action@v2
        with:
          push: true
          context: mit-scheme:11/
          tags: |
            mit-scheme:11
            mit-scheme:11-bullseye-slim
            mit-scheme:latest
      -
        name: Build and push schemers/mit-scheme:10
        id: docker_build_mit-scheme:10
        uses: docker/build-push-action@v2
        with:
          push: true
          context: mit-scheme:10/
          tags: |
            mit-scheme:10
            mit-scheme:10-bullseye-slim
