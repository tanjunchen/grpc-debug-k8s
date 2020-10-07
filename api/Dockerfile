FROM alpine

# 维护者
MAINTAINER tanjunchen

# 当前的工作目录
WORKDIR /go/src

# 复制当前 add 二进制文件
COPY ./api /go/src

# 确保执行权限
RUN chmod +x ./api

# 运行命名
ENTRYPOINT ["/go/src/api"]

EXPOSE 8080
