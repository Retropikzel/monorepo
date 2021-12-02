
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - owl/**/Dockerfile

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
        name: Build and push schemers/owl:head
        id: docker_build_owl:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: owl:head/
          tags: |
            owl:head
            owl:head-bullseye-slim
      -
        name: Build and push schemers/owl:0
        id: docker_build_owl:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: owl:0/
          tags: |
            owl:0
            owl:0-bullseye-slim
            owl:latest
