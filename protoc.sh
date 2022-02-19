set -xe

protoc --version
protoc -I./protobuf helloworld.proto\
  --go_out=./api/protos/helloworld/ --go_opt=paths=source_relative \
  --go-grpc_out=./api/protos/helloworld/ --go-grpc_opt=paths=source_relative \
  --dart_out=grpc:helloworld/lib/protos/ \

protoc -I./protobuf chat.proto google/protobuf/timestamp.proto google/protobuf/empty.proto\
  --go_out=./api/protos/chat/ --go_opt=paths=source_relative \
  --go-grpc_out=./api/protos/chat/ --go-grpc_opt=paths=source_relative \
  --dart_out=grpc:helloworld/lib/protos/chat/  \

