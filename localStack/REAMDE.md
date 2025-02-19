

# RUN ENV

docker run -d --name localstack -p 4566:4566 -p 4571:4571 localstack/localstack

# Verify config

aws --endpoint-url=http://localhost:4566 s3 ls

