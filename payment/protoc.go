package payment

//go:generate protoc -I . --go_out=../golang/payment --go_opt paths=source_relative --go-grpc_out ../golang/payment --go-grpc_opt paths=source_relative  payment.proto
