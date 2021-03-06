FROM centos:latest
RUN yum install wget -y 
RUN yum install sudo -y 
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo 
RUN rpm --import http://pkg.jenkins.io/redhat/jenkins.io.key 
RUN yum install initscripts -y && yum install jenkins -y 
RUN yum install java-11-openjdk.x86_64 -y ; yum install git -y ; yum install python3 -y
RUN touch /etc/yum.repos.d/kubernetes.repo 
RUN echo "[kubernetes]" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "name=Kubernetes" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "enabled=1" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "gpgcheck=1" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "repo_gpgcheck=1" >> /etc/yum.repos.d/kubernetes.repo 
RUN echo "gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" >> /etc/yum.repos.d/kubernetes.repo 
 
RUN yum install -y kubectl
EXPOSE 8080
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /jenkins
USER jenkins
ENV USER jenkins
CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]
