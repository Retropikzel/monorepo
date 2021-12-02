
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - sisc/**/Dockerfile

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
        name: Build and push schemers/sisc:1.16
        id: docker_build_sisc:1.16
        uses: docker/build-push-action@v2
        with:
          push: true
          context: sisc:1.16/
          tags: |
            sisc:1.6
            sisc:1
            sisc:1-bullseye-slim
            sisc:latest
