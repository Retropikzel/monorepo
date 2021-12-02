
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - pc-scheme/**/Dockerfile

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
        name: Build and push schemers/pc-scheme:3.03
        id: docker_build_pc-scheme:3.03
        uses: docker/build-push-action@v2
        with:
          push: true
          context: pc-scheme:3.03/
          tags: |
            pc-scheme:3.03
            pc-scheme:3
            pc-scheme:3-bullseye-slim
            pc-scheme:latest
