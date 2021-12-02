
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - vx/**/Dockerfile

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
        name: Build and push schemers/vx:head
        id: docker_build_vx:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: vx:head/
          tags: |
            vx:head
            vx:head-bullseye-slim
            vx:latest
