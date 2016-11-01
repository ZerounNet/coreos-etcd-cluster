FROM zerounnet/swarm-sshd-alpine

MAINTAINER ZerounNet

RUN	apk add --no-cache ca-certificates openssl tar ; \
	ETCD_VER=v3.0.13 && \
	DOWNLOAD_URL=https://github.com/coreos/etcd/releases/download && \
	wget ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
	tar xzvf etcd-${ETCD_VER}-linux-amd64.tar.gz && \
	mv etcd-${ETCD_VER}-linux-amd64/etcd* /bin/ && \
	apk del --purge tar openssl && \
	rm -Rf etcd-${ETCD_VER}-linux-amd64* /var/cache/apk/*

EXPOSE 2379 2380

CMD ["/bin/etcd"]
