#!/bin/sh

IMAGE_NAME="my-custom-arch"
CONTAINER_NAME="my-arch-dev-instance"
SECRET_FILE="docker_secret_pass.txt"
DOCKERFILE_NAME="Dockerfile"

# --- Style and Color Definitions for Output ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Script Start ---

echo -e "${GREEN}► Starting the Docker build and run process...${NC}"

# 1. Verify that the Dockerfile exists
if [ ! -f "$DOCKERFILE_NAME" ]; then
    echo -e "${RED}Error: Dockerfile not found! Please ensure a file named '${DOCKERFILE_NAME}' exists in this directory.${NC}"
    exit 1
fi

# 2. Securely generate a temporary password file for the build
# We generate a 16-character random password.
PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
echo -n "$PASSWORD" > "$SECRET_FILE"
chmod 600 "$SECRET_FILE"
echo -e "${YELLOW}ℹ A temporary password has been generated for the build process: ${GREEN}$PASSWORD${NC}"
echo -e "${YELLOW}  (This will be deleted automatically after the build).${NC}"


# 3. Clean up any existing container with the same name
# This makes the script re-runnable without errors.
if [ "$(docker ps -a -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo -e "${YELLOW}ℹ Found an existing container named '${CONTAINER_NAME}'. Stopping and removing it...${NC}"
    docker stop "$CONTAINER_NAME" > /dev/null
    docker rm "$CONTAINER_NAME" > /dev/null
fi

# 4. Build the Docker image using the secret
echo -e "${GREEN}► Building the Docker image '${IMAGE_NAME}'...${NC}"
# We use DOCKER_BUILDKIT=1 to ensure secret mounting is enabled.
DOCKER_BUILDKIT=1 docker build --secret id=user_password,src="$SECRET_FILE" -t "$IMAGE_NAME" .

# Check if the build command was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}✖ Docker build failed. Please check the output for errors.${NC}"
    # Clean up the secret file even on failure
    rm -f "$SECRET_FILE"
    exit 1
fi

# 5. CRITICAL: Remove the secret password file immediately after a successful build
rm -f "$SECRET_FILE"
echo -e "${GREEN}✔ Successfully built the image and deleted the temporary secret file.${NC}"

# 6. Run the new Docker container in detached mode
echo -e "${GREEN}► Starting container '${CONTAINER_NAME}'...${NC}"
docker run -it -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
if [ $? -ne 0 ]; then
    echo -e "${RED}✖ Failed to start the container.${NC}"
    exit 1
fi
echo -e "${GREEN}✔ Container is now running in the background.${NC}"

# 7. Connect to the container's terminal
echo -e "${GREEN}► Connecting to the container's terminal. Type 'exit' to leave.${NC}"
echo "=========================================================="
docker exec -it "$CONTAINER_NAME" /bin/bash

# --- Script End ---
echo "=========================================================="
echo -e "${GREEN}✔ You have exited the container. The container '${CONTAINER_NAME}' is still running.${NC}"
echo -e "  To stop it, run: ${YELLOW}docker stop ${CONTAINER_NAME}${NC}"
echo -e "  To connect again, run: ${YELLOW}docker exec -it ${CONTAINER_NAME} /bin/bash${NC}"
```
