
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - guile/**/Dockerfile

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
        name: Build and push schemers/guile:3
        id: docker_build_guile:3
        uses: docker/build-push-action@v2
        with:
          push: true
          context: guile:3/
          tags: |
            guile:3
            guile:3.0
            guile:3-bullseye-slim
            guile:latest
      -
        name: Build and push schemers/guile:2
        id: docker_build_guile:2
        uses: docker/build-push-action@v2
        with:
          push: true
          context: guile:2/
          tags: |
            guile:2
            guile:2.2
