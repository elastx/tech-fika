FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y ca-certificates
ADD https://get.aquasec.com/microscanner .
RUN chmod +x microscanner
#RUN ./microscanner NmRlZjEwZjRiYjcw

CMD ["/bin/bash"]
