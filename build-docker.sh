#!/bin/sh

echo -n "password" > testuser_password.txt

docker build --secret id=user_password,src=devuser_password.txt -t my-custom-arch .

docker run -it -d --name my-configured-arch my-custom-arch

docker exec -it my-configured-arch /bin/bash
