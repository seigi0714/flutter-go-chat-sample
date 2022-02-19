package controller

import (
	"context"
	"encoding/json"
	pb "go-flutter-chat/protos/chat"
	"log"

	"github.com/go-redis/redis/v8"
	"github.com/golang/protobuf/ptypes"
	"github.com/golang/protobuf/ptypes/empty"
)

type chatServer struct {
	pb.UnimplementedChatServer
}

func NewChatServer() pb.ChatServer {
	return &chatServer{}
}

var roomA = "1"

func (s *chatServer) GetMessages(_ *empty.Empty, stream pb.Chat_GetMessagesServer) error {
	// ctx, cancelFunc := context.WithTimeout(context.Background(), time.Second*10)
	// defer cancelFunc()
	// grpc.DialContext(ctx, ":50051")

	client := NewRedisClient()

	pubsub := client.Subscribe(client.Context(), roomA)
	defer pubsub.Close()

	_, err := pubsub.Receive(client.Context())
	if err != nil {
		log.Fatal(err)
	}

	ch := pubsub.Channel()

	for msg := range ch {
		var message pb.Message
		err := json.Unmarshal([]byte(msg.Payload), &message)
		if err != nil {
			log.Fatal(err)
		}

		log.Println("メッセージを受信 ", message)

		if err := stream.Send(&message); err != nil {
			log.Println("error :: ", err)
			return err
		} else {
			// log.Println("メッセージを受信 ", message)
		}
	}
	return nil
}

func (s *chatServer) PostMessage(ctx context.Context, request *pb.Message) (*pb.Result, error) {
	client := NewRedisClient()

	if request.GetCreatedAt() == nil {
		request.CreatedAt = ptypes.TimestampNow()
	}

	message, _ := json.Marshal(request)

	log.Println("message", message)

	_ = client.Publish(ctx, roomA, message).Err()

	result := &pb.Result{
		Result: true,
	}

	return result, nil
}

func NewRedisClient() *redis.Client {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	return client
}
