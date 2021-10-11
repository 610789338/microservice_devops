# 利用docker实现的服务发布方案

分为以下几步：
1，可执行文件和配置文件自动编译上传到中心服务器（未实现）
2，根据新的执行文件配置文件重新制作docker image（已实现）
3，将docker image发布到目标服务器上（未实现）
4，利用docker image启动新的docker container（已实现）
5，启动容器中的服务（已实现）

## 文件上传
假设中心服务器上有ms_gate和service_a两个目录
当更改了代码或静态配置之后，将可执行文件和配置文件替换到对应的source/bin目录下

## docker image制作
docker_image_build.sh脚本负责根据Dockerfile和source目录制作新的docker image

## docker image发布到目标服务器
利用docker save导出docker image
将docker image上传到目标服务器
在目标服务器上用docker load导入docker image

## 启动docker container
docker_app_start.sh脚本负责启动容器，容器网络采用--network=host模式
脚本负责分配可用的端口资源给容器，其他动态配置通过指定环境变量（env.list）传入容器

## 启动docker container中的服务
本想通过开机启动（rc.local）或docker CMD来启动服务，但两种方式都有问题：
rc.local在容器中貌似无效果
CMD运行结束容器也跟着退出，不方便排查问题
最终采用docker container exec的方式运行容器内的launch.sh脚本来启动服务

launch.sh会先根据环境变量替换config.json中的配置，然后启动服务
