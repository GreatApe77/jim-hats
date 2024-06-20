#!/bin/sh

# Function to bring down Docker Compose services
cleanup() {
  echo "Cleaning up Docker containers..."
  cd ..
  docker compose --file docker-compose-test.yml down
}

# Ensure cleanup is called on script exit
trap cleanup EXIT

# Navigate to the parent directory
cd ..

# Start Docker Compose with the test configuration
docker compose --file docker-compose-test.yml up -d --build

# Wait for the services to be fully up and running
sleep 1

# Navigate back to the server directory
cd ./server

# Run the Prisma migrations
npx dotenv -e .env.test -- npx prisma migrate deploy

# Run the tests, excluding unit tests
npx dotenv -e .env.test -- npx vitest --watch=false --reporter=verbose --exclude=**/unit/*.ts

# Capture the exit code of the tests
TEST_EXIT_CODE=$?

# Exit with the test exit code (to indicate success/failure)
exit $TEST_EXIT_CODE
