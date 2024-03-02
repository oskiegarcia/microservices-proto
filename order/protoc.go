package order

//go:generate protoc -I . --go_out=../golang/order --go_opt paths=source_relative --go-grpc_out ../golang/order --go-grpc_opt paths=source_relative  order.proto
