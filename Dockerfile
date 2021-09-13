FROM jupyter/base-notebook
USER root

RUN useradd -m -u 501 -o -s /bin/bash bob
RUN echo 'bob:passwordBob' | chpasswd
RUN useradd -m -u 502 -o -s /bin/bash alice
RUN echo 'alice:passwordAlice' | chpasswd

RUN chmod -R 700 /home/bob
RUN chmod -R 700 /home/alice

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
