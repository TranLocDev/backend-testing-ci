#!/bin/bash

# Script để pull Docker image từ GitLab Container Registry
# Sử dụng: ./pull-image.sh [GITLAB_USERNAME] [GITLAB_TOKEN] [PROJECT_PATH]

set -e  # Exit on any error

# Kiểm tra tham số đầu vào
# if [ $# -lt 3 ]; then
#     echo "Usage: $0 <GITLAB_USERNAME> <GITLAB_TOKEN> <PROJECT_PATH>"
#     echo "Example: $0 myuser abc123def mygroup/myproject"
#     exit 1
# fi

GITLAB_USERNAME=tranloc120603
GITLAB_TOKEN=glpat-Q998B6oGY-VjRXl64LTht286MQp1OmVvcGc0Cw.01.12159u1u9
PROJECT_PATH=tranloc120603/registry

# Thông tin image
REGISTRY="registry.gitlab.com"
IMAGE_NAME="backend-testing-container"
TAG="latest"
FULL_IMAGE_NAME="${REGISTRY}/${PROJECT_PATH}/${IMAGE_NAME}:${TAG}"

echo "🚀 Starting Docker image pull..."
echo "Image: ${FULL_IMAGE_NAME}"

# Đăng nhập vào GitLab Container Registry
echo "🔐 Logging into GitLab Container Registry..."
echo "${GITLAB_TOKEN}" | docker login ${REGISTRY} -u ${GITLAB_USERNAME} --password-stdin

# Pull image
echo "📥 Pulling Docker image..."
docker pull ${FULL_IMAGE_NAME}

# Kiểm tra image đã pull thành công
echo "✅ Verifying image pull..."
if docker images --format "table {{.Repository}}:{{.Tag}}" | grep -q "${FULL_IMAGE_NAME}"; then
    echo "🎉 Image pulled successfully!"
    docker images --filter reference="${FULL_IMAGE_NAME}" --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
    echo ""
    echo "💡 To run the image, use:"
    echo "docker run -p [HOST_PORT]:[CONTAINER_PORT] ${FULL_IMAGE_NAME}"
    echo "Example: docker run -p 3000:3000 ${FULL_IMAGE_NAME}"
else
    echo "❌ Failed to pull image"
    exit 1
fi