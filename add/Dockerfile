FROM alpine

# 维护者
MAINTAINER tanjunchen

# 当前的工作目录
WORKDIR /go/src

# 复制当前 add 二进制文件
COPY ./add /go/src

# 确保执行权限
RUN chmod +x ./add

# 运行命名
ENTRYPOINT ["/go/src/add"]

EXPOSE 3000
