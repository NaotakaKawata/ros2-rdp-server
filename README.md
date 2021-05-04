# ros2-rdp-server

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

It is a container with ROS2 environment built that allows remote desktop connection and SSH connection.

![desktop](https://user-images.githubusercontent.com/38690306/116877481-f7d59000-ac58-11eb-9366-5ac28b5d33a2.jpg)

![ssh](https://user-images.githubusercontent.com/38690306/116877708-3ff4b280-ac59-11eb-9984-132d21b2ce3c.jpg)

---

## Features
- It is possible to use software that requires GUI operation such as Rviz and Gazebo
- With SSH connection, you don't have to worry about slow screen drawing.
- It is possible to keep the container secure by disabling root login and setting a password
- Since it is mounted in the connection source directory (workdir), it is easy to exchange files with the container.

---

## Configuration
This container consists of the following.  
- OS：Ubuntu:18.04 (eloquent) and 20.04 (foxy)
  - Supports Japanese input environment（Mozc）
  - sudo-user created（ID：user，PASS：root）
- Desktop：Xfce
  - Installed xfce4-goodies
- Remote desktop server：Xrdp
  - Supports bidirectional clipboard sharing
  - Supports multiple displays
  - Denied root login
- SSH server：openssh-server
  - Denied root login

To change the settings such as user name, rewrite the settings file (.env file) and build.

---

## Quick Start
If you use Docker Hub image, you can execute it with the following command.
In the example below, remote desktop connection is possible with 13389port and SSH connection is possible with 10022port.
```
#eloquent
$ docker run --rm -it -p 13389:3389 -p 10022:22 --shm-size=256m <absolute pathname on host>:/home/user/Workdir/:rw naotakakawata/eloquent-rdp-server
#foxy
$ docker run --rm -it -p 13389:3389 -p 10022:22 --shm-size=256m <absolute pathname on host>:/home/user/Workdir/:rw naotakakawata/foxy-rdp-server
```

---

## Build
Clone the following repository.
```
$ git clone https://github.com/NaotakaKawata/ros2-rdp-server
```
Next, open the .env file in the directory of the ROS environment you want to try and change the following settings．
```
root_password=super            #root password
user_name=user                 #user name
user_password=root             #user password
container_name=ubuntu-desktop  #container name
host_name=Challenger           #host name
ros_pkg=desktop                #ros-package name（desktop, ros-base）
shm_size=256m                  #size of temporary directory
RDPport=33890                  #RDP port
SSHport=22000                  #SSH port
```

For remote desktop and SSH settings, change the config.

Finally, build with the following command.
```
$ cd ros2-rdp-server/<ros-distro>/
$ Docker-compose up --build
```

---

## Usage
The user name and password for remote desktop connection and SSH connection are as follows.

（ID：user，PASS：root）

Remote desktop connection
```
Windows10 remote desktop connection -> Computer(C):"localhost:33890" -> Connect(N)
```

![rdp](https://user-images.githubusercontent.com/38690306/116878198-fb1d4b80-ac59-11eb-932b-e04493890287.jpg)

![remotejpg](https://user-images.githubusercontent.com/38690306/116873764-2c464d80-ac53-11eb-8b79-7b1da9f1b4af.jpg)

SSH connection
```
TeraTerm -> ホスト(T):"localhost:33890"-> TCPポート#(P):"localhost:22000" -> OK
```
![teratarm](https://user-images.githubusercontent.com/38690306/116877859-73374180-ac59-11eb-833d-4aa29d23feb1.jpg)

---

## License
GitHub Changelog Generator is released under the [MIT License](http://www.opensource.org/licenses/MIT).

---

## Acknowledgements
This Docker image is based on [Rosyuku/ubuntu-rdp](https://github.com/Rosyuku/ubuntu-rdp)

---

## Feedback 
Any questions or suggestions?

You are welcome to discuss it on:

[![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/dancing_nanachi)
---