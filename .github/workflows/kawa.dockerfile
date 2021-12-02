
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - kawa/**/Dockerfile

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
        name: Build and push schemers/kawa:head
        id: docker_build_kawa:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: kawa:head/
          tags: |
            kawa:head
            kawa:head-bullseye-slim
      -
        name: Build and push schemers/kawa:3.1
        id: docker_build_kawa:3.1
        uses: docker/build-push-action@v2
        with:
          push: true
          context: kawa:3.1/
          tags: |
            kawa:3.1
            kawa:3
            kawa:3-bullseye-slim
            kawa:latest
