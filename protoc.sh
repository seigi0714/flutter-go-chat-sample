set -xe

protoc --version
protoc -I./protobuf helloworld.proto\
  --go_out=./api/protos --go_opt=paths=source_relative \
  --go-grpc_out=./api/protos --go-grpc_opt=paths=source_relative \
  --dart_out=grpc:helloworld/lib/protos

# protoファイル内でtimestamp.protoなどをimportしたときに必要
# protoc -I=/proto/protos timestamp.proto wrappers.proto\
#   --dart_out=./helloworld/protos