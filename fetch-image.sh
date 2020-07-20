#!/bin/bash
images=(k8s.gcr.io/pause:3.1=gcr.azk8s.cn/google-containers/pause:3.1
gcr.io/google_containers/defaultbackend-amd64:1.4=gcr.azk8s.cn/google-containers/defaultbackend-amd64:1.4
k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1=registry.cn-hangzhou.aliyuncs.com/google_containers/kubernetes-dashboard-amd64:v1.10.1
k8s.gcr.io/heapster-influxdb-amd64:v1.3.3=registry.cn-hangzhou.aliyuncs.com/google_containers/heapster-influxdb-amd64:v1.3.3
k8s.gcr.io/heapster-amd64:v1.5.2=registry.cn-hangzhou.aliyuncs.com/google_containers/heapster-amd64:v1.5.2
k8s.gcr.io/heapster-grafana-amd64:v4.4.3=registry.cn-hangzhou.aliyuncs.com/google_containers/heapster-grafana-amd64:v4.4.3
)


OIFS=$IFS; # 保存旧值

for image in ${images[@]};do
    IFS='='
    set $image
    docker pull $2
    docker tag  $2 $1
    docker rmi  $2
    docker save $1 > 1.tar && microk8s.ctr --namespace k8s.io image import 1.tar && rm 1.tar
    IFS=$OIFS; # 还原旧值
done
