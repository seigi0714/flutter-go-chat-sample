# Dockerfile
 
FROM golang:latest
 
ENV SRC_DIR=/go/src/github.com/seigi0714/flutter-go-chat-sample/api
 
WORKDIR $SRC_DIR
 
ADD . $SRC_DIR
 
RUN go get -u google.golang.org/grpc \
    && go get -u github.com/golang/protobuf/protoc-gen-go