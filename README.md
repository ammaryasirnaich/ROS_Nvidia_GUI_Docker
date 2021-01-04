# ROS_Nvidia_GUI_Docker
The Repository Contains the dockerfile for setting up an ROS docker container which supports GPU.Also, I can run GUI application from inside the container 


#### RUN the below commoand at the terminal before starting the docker container
>xhost local:root

#### Start the ROS container
> docker run -it --rm -e DISPLAY=${DISPLAY} --runtime=nvidia --net=host --privileged -env="QT_X11_NO_MITSHM=1" -v /tmp/.X11-unix:/tmp/.X11-unix ENTER_IMAGE_ID /bin/bash