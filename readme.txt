
- build and logs
docker-compose up

- build with deamon
docker-compose up -d

- logs
docker compose logs

- ab
docker compose exec benchmark sh  -c "ab  -c 15 -n 1000 http://loadbalancer/"

