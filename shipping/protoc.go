package proto

//go:generate protoc -I . --go_out=../golang/shipping --go_opt paths=source_relative --go-grpc_out ../golang/shipping --go-grpc_opt paths=source_relative  shipping.proto
