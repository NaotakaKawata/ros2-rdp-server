# ros2-rdp-server

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

リモートデスクトップ接続とSSH接続が可能なROS2環境構築済みのコンテナです．

![desktop](https://user-images.githubusercontent.com/38690306/116877481-f7d59000-ac58-11eb-9366-5ac28b5d33a2.jpg)

![ssh](https://user-images.githubusercontent.com/38690306/116877708-3ff4b280-ac59-11eb-9984-132d21b2ce3c.jpg)

---

## Features
- RvizやGazeboなどのGUI操作が必要なソフトウェアを使用することが可能
- SSH接続にした場合は, 画面の描画の遅さに悩むことがなくなる
- rootログインの無効化とパスワード設定によりコンテナをセキュアに保つことが可能
- 接続元のディレクトリ(workdir)にマウントしているため，コンテナとのファイルのやり取りが容易

---

## Configuration
このコンテナは以下で構成しています．  
- OS：Ubuntu:18.04 (eloquent) and 20.04 (foxy)
  - 日本語入力環境対応（Mozc）
  - sudo権限付きuser作成済み（ID：user，PASS：root）
- デスクトップ環境：Xfce
  - xfce4-goodiesインストール済み
- リモートデスクトップサーバー：Xrdp
  - リモート越しの双方向のclipborad共有に対応
  - マルチディスプレイに対応
  - rootログイン拒否設定済み
- SSHサーバー：openssh-server
  - rootログイン拒否設定済み

ユーザ名等の設定を変更する場合は，設定ファイル(.envファイル)を書き換えてBuildする．

---

## Quick Start
Docker Hubのimageをご利用いただく場合，以下のコマンドで実行できます．
以下の例では13389portでリモートデスクトップ接続，10022portでSSH接続が可能です．
```
#eloquent
$ docker run --rm -it -p 13389:3389 -p 10022:22 --shm-size=256m naotakakawata/eloquent-rdp-server
#foxy
$ docker run --rm -it -p 13389:3389 -p 10022:22 --shm-size=256m naotakakawata/foxy-rdp-server
```

---

## Build
以下のリポジトリをCloneする．
```
$ git clone https://github.com/NaotakaKawata/ros2-rdp-server
```
次に，試したいROS環境のディレクトリ内の.envファイルを開いて以下の設定を変更する．
```
root_password=super            #rootのパスワード
user_name=user                 #作成するuserのユーザ名
user_password=root             #作成するuserのパスワード
container_name=ubuntu-desktop  #作成するコンテナの名前
host_name=Challenger           #Ubuntuのホスト名
ros_pkg=desktop                #インストールするROSパッケージ（desktop, ros-base）
shm_size=256m                  #一時ファイル領域
RDPport=33890                  #リモートデスクトップ接続のport
SSHport=22000                  #SSH接続のport
```
リモートデスクトップやSSHの設定はconfig内の設定ファイルを変更する．

最後に以下のコマンドでビルドします．
```
$ cd ros2-rdp-server/<ros-distro>/
$ Docker-compose up --build
```

---

## Usage
リモートデスクトップ接続およびSSH接続のユーザー名とパスワードはそれぞれ以下の通りです．  
（ID：user，PASS：root）

リモートデスクトップ接続の場合
```
Windows10のリモートデスクトップ接続 -> コンピューター(C):"localhost:33890" -> 接続(N)
```

![rdp](https://user-images.githubusercontent.com/38690306/116878198-fb1d4b80-ac59-11eb-932b-e04493890287.jpg)

![remotejpg](https://user-images.githubusercontent.com/38690306/116873764-2c464d80-ac53-11eb-8b79-7b1da9f1b4af.jpg)

SSH接続の場合
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