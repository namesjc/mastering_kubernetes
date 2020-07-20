PACKAGES=`cat ./package-list.txt`;

for package in $PACKAGES; do docker pull "$package"; done

docker images | tail -n +2 | grep -v "<none>" | awk '{printf("%s:%s\n", $1, $2)}' | while read IMAGE; do
    for package in $PACKAGES;
    do
        if [[ $package != *[':']* ]];then package="$package:latest"; fi

        if [ $IMAGE == $package ];then
            echo "[find image] $IMAGE"
            filename="$(echo $IMAGE| tr ':' '-' | tr '/' '-').tar"
            echo "[save as] $filename"
            docker save ${IMAGE} -o $filename
        fi
    done
done