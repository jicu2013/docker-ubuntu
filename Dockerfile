FROM ubuntu
MAINTAINER jicu2013
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN set -ex; \
	apt-get update -y; \
	apt-get install -y --no-install-recommends \
		openssh-server \
		net-tools

RUN sed -i 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' > /etc/ssh/sshd_config
RUN update-rc.d ssh defaults
RUN echo "root:toor" | chpasswd

EXPOSE 22 80
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]
