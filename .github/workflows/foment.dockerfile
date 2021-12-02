
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - foment/**/Dockerfile

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
        name: Build and push schemers/foment:head
        id: docker_build_foment:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: foment:head/
          tags: |
            foment:head
            foment:head-bullseye-slim
      -
        name: Build and push schemers/foment:0
        id: docker_build_foment:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: foment:0/
          tags: |
            foment:0
            foment:0-bullseye-slim
            foment:latest
