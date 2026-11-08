curl -fsSL https://get.docker.com | bash
docker run -d --restart always --name redis-stack -p 6379:6379 -e REDIS_ARGS="--requirepass mypassword" redis/redis-stack-server:latest