1. Create with aws cli ec2 instance from Ubuntu image (ami-053b0d53c279acc90)
2. Setup docker via user data on your instance (see documentation). Docker should listen on
   instance local tcp port 127.0.0.1:2375 (see documentation). Do not forget add ubuntu user to
   docker group. See next slide for connection diagram.
3. Write on your local computer Dockerfile for nginx server setup based on centos9 docker
   image. Use Hometask#1 as example. SELinux and systemctl are not used in this case. Create some content for your web server in ./html folder. Update Dockerfile to copy local ./html folder to your instance web content folder.
4. Create local port (5566) forwarding tunnel to your instance using ssh (see Hometask #7)
5. Run localy docker build (docker -H localhost:5566 build ... ) command to build docker image
   on your instance.
6. Run nginx docker container as daemon on your instance tcp port 80
   (docker -H localhost:5566 run ... )


## How to start:
aws ec2 run-instances \
--image-id ami-01bc990364452ab3e \
--count 1 \
--instance-type t2.micro \
--user-data file://setup-docker-user-data.sh \
--region us-east-1

ssh -i hw-key.pem -L 5566:127.0.0.1:2375 ubuntu@http://54.226.55.19/

docker -H localhost:5566 build -t my-nginx .

docker -H localhost:5566 run -d -p 80:80 --name nginx-server my-nginx


