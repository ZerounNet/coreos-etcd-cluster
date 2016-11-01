# swarm-etcd-cluster

git clone https://github.com/ZerounNet/swarm-etcd-cluster.git
docker build -t zerounnet/swarm-etcd-cluster swarm-etcd-cluster


#On each etcd node, specify the cluster members:
TOKEN=etcd-cluster
CLUSTER_STATE=new
NAME_1=etcd-cluster1
NAME_2=etcd-cluster2
NAME_3=etcd-cluster3
HOST_1=192.168.1.221
HOST_2=192.168.1.222
HOST_3=192.168.1.223
CLUSTER=${NAME_1}=http://${HOST_1}:2380,${NAME_2}=http://${HOST_2}:2380,${NAME_3}=http://${HOST_3}:2380

# Run this on each machine:
## For machine 1
THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
docker run -itd --restart=always --name ${THIS_NAME} -p 2379:2379 -p 2380:2380 zerounnet/swarm-etcd-cluster etcd --data-dir=data.etcd --name ${THIS_NAME} --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://0.0.0.0:2380 --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://0.0.0.0:2379 --initial-cluster ${CLUSTER} --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}	

## For machine 2
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
docker run -itd --restart=always --name ${THIS_NAME} -p 2379:2379 -p 2380:2380 zerounnet/swarm-etcd-cluster etcd --data-dir=data.etcd --name ${THIS_NAME} --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://0.0.0.0:2380 --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://0.0.0.0:2379 --initial-cluster ${CLUSTER} --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

## For machine 3
THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
docker run -itd --restart=always --name ${THIS_NAME} -p 2379:2379 -p 2380:2380 zerounnet/swarm-etcd-cluster etcd --data-dir=data.etcd --name ${THIS_NAME} --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://0.0.0.0:2380 --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://0.0.0.0:2379 --initial-cluster ${CLUSTER} --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

