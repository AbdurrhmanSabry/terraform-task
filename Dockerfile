FROM jenkins/jenkins:2.332.3-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
RUN apt-get update 
RUN apt-get install openjdk-8-jdk -y 
RUN touch /var/run/docker.sock && chown jenkins /var/run/docker.sock
RUN apt-get install openssh-server -y
USER jenkins
RUN mkdir -p /var/jenkins_home/.ssh
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"