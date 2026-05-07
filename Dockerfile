# FROM ubuntu:latest
# RUN apt update 
# RUN apt install nginx -y
# WORKDIR /var/www/html
# COPY . .
# EXPOSE 80
# CMD ["nginx","-g", "daemon off;"]


FROM ubuntu
ENTRYPOINT [ "sleep"]
CMD [ "1000"]