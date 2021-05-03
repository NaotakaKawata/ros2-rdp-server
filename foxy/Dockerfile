FROM ubuntu:20.04
LABEL maintainer="Naotaka Kawata"
LABEL version="1.0"

ARG host_name="Challenger"
ENV DEBIAN_FRONTEND=noninteractive \
    HOSTNAME=$host_name
ENV ROS_DISTRO=foxy
ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ARG ros_pkg=desktop
ARG ROS_PKG=$ros_pkg

#ARG http_proxy=http://proxy_address:port/
#ARG https_proxy=http://proxy_address:port/
#ENV HTTP_PROXY=$http_proxy
#ENV HTTPS_PROXY=$https_proxy

#Locale and Language setting
RUN apt-get update && \
    apt-get install -y ibus-mozc language-pack-ja-base language-pack-ja fonts-takao
ARG Use_Language="en_US.UTF-8"
ARG Use_TimeZone="Asia/Tokyo"
ENV LANG=$Use_Language \
    TZ=$Use_TimeZone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    locale-gen $LANG && \
    echo LANG=$LANG >> /etc/default/locale

#User setting
ARG root_password="super"
ARG user_name="user"
ARG user_password="root"
RUN echo root:$root_password | chpasswd && \
    apt-get update && apt-get install -y openssl sudo && \
    useradd -m -G sudo $user_name -p $(openssl passwd -1 $user_password) --shell /bin/bash

#RDP setting
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-terminal xfce4-goodies xrdp && \
    adduser xrdp ssl-cert && \
    update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper
COPY ./config/xrdp/sesman.ini /etc/xrdp/sesman.ini
COPY ./config/xrdp/xrdp.ini /etc/xrdp/xrdp.ini
COPY ./config/xrdp/default.pa /etc/xrdp/pulse/default.pa
EXPOSE 3389

#SSH setting
RUN apt-get update && \
    apt-get install -y openssh-server && mkdir /var/run/sshd
COPY ./config/ssh/sshd_config /etc/ssh/sshd_config
COPY ./config/ssh/hosts.allow /etc/hosts.allow
EXPOSE 22

#Startup setting
RUN apt-get update && \
    apt-get install -y supervisor
ADD ./config/supervisord/* /etc/supervisor/conf.d/

#Install Preferred package
RUN apt-get update && \
    apt-get install -y \
    git gedit \
    wget curl net-tools \
    build-essential software-properties-common \
    cmake gnupg2 lsb-release

CMD ["bash", "-c", "/usr/bin/supervisord -c /etc/supervisor/supervisord.conf"]

#ROS Tutorial Setting
RUN curl -Ls https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ros-${ROS_DISTRO}-${ROS_PKG} \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs

# install dependencies using rosdep
RUN apt-get update && \
    cd ${ROS_ROOT} && \
    rosdep init && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

#clean up
RUN apt-get clean && apt-get autoremove && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# setup entrypoint
COPY ./packages/ros_entrypoint.sh /ros_entrypoint.sh
RUN echo 'source /opt/ros/foxy/setup.bash' >> /home/$user_name/.bashrc
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
WORKDIR /