
# ORDER
ORDER_DIR := ./order

# PAYMENT
PAYMENT_DIR := ./payment

# SHIPPING
SHIPPING_DIR := ./shipping

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## help: print this tag help
.PHONY: help/tag
help/tag:
	@echo 'Usage:'
	@echo 'make tag/order tag=v1.0.2'


.PHONY: about
about: ## Display info related to the build
	@echo "OS: ${OS}"
	@echo "Shell: ${SHELL} ${SHELL_VERSION}"
	@echo "Protoc version: $(shell protoc --version)"
	@echo "Go version: $(shell go version)"
	@echo "Openssl version: $(shell openssl version)"


# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## tidy: format code and tidy modfile
.PHONY: tidy
tidy:
	cd ${ORDER_DIR} && go fmt ./...
	cd ${ORDER_DIR} && go mod tidy -v
	cd ${PAYMENT_DIR} && go fmt ./...
	cd ${PAYMENT_DIR} && go mod tidy -v
	cd ${SHIPPING_DIR} && go fmt ./...
	cd ${SHIPPING_DIR} && go mod tidy -v

# ==================================================================================== #
# GENERATE
# ==================================================================================== #

## clean: clean generated code and binaries
.PHONY: clean
clean:
	rm -f golang/${ORDER_DIR}/*.go golang/${PAYMENT_DIR}/*.go golang/${SHIPPING_DIR}/*.go


## proto/install: install proto dependencies
.PHONY: proto/install
proto/install:
	cd ${ORDER_DIR} &&  go get google.golang.org/genproto/googleapis/api google.golang.org/grpc/cmd/protoc-gen-go-grpc google.golang.org/protobuf/cmd/protoc-gen-go
	cd ${PAYMENY_DIR} &&  go get google.golang.org/genproto/googleapis/api google.golang.org/grpc/cmd/protoc-gen-go-grpc google.golang.org/protobuf/cmd/protoc-gen-go
	cd ${SHIPPING_DIR} &&  go get google.golang.org/genproto/googleapis/api google.golang.org/grpc/cmd/protoc-gen-go-grpc google.golang.org/protobuf/cmd/protoc-gen-go


## generate: generate proto messages and services
.PHONY: generate
generate: clean
	cd ${ORDER_DIR} &&  go generate ./...
	cd ${PAYMENT_DIR} && go generate ./...
	cd ${SHIPPING_DIR} && go generate ./...


# ==================================================================================== #
# GIT TAGS
# Usage:  make tag/order tag=v1.0.2
# ==================================================================================== #
## tag/order: Create git tag for order service
.PHONY: tag/order
tag/order:
	git tag -fa golang/order/${tag} -m "golang/order/${tag}"
	git push origin refs/tags/golang/order/${tag}

## tag/payment: Create git tag for payment service
.PHONY: tag/payment
tag/payment:
	git tag -fa golang/payment/${tag} -m "golang/payment/${tag}"
	git push origin refs/tags/golang/payment/${tag}

## tag/shipping: Create git tag for shipping service
.PHONY: tag/shipping
tag/shipping:
	git tag -fa golang/shipping/${tag} -m "golang/shipping/${tag}"
	git push origin refs/tags/golang/shipping/${tag}

