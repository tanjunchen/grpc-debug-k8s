.PHONY: deploy_add
deploy_add:
	@echo "Building docker image ..."
	cd add \
	&& GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./add \
	&& docker build . -t tanjunchen/add-service:v1.0
	@echo "Deploying in kubernetes ..."
	kubectl apply -f ./deployment/tanjunchen-summation-service.yaml

.PHONY: deploy_api
deploy_api:
	@echo "building api in debug mode..."
	cd api \
	&& GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./api \
	&& docker build . -t tanjunchen/api-service:v1.0
	@echo "Deploying in kubernetes ..."
	kubectl apply -f ./deployment/api-service-tanjunchen.yaml

.PHONY: debug_deploy_api
debug_deploy_api:
	@echo "building api in debug mode..."
	cd api \
	&& GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./api-debug \
	&& docker build -f Dockerfile.debug -t tanjunchen/api-debug:v1.0
	@echo "Deploying in kubernetes ..."
	kubectl apply -f ./deployment/api-debug-service-tanjunchen.yaml

.PHONY: delete_debug_api
delete_debug_api:
	kubectl delete deployment debug-api-deploy

.PHONY: delete_summation
delete_summation:
	@echo "Deleting add-service ..."
	kubectl delete svc add-service
	@echo "Deleting add-deployment ..."
	kubectl delete deployment add-deployment

.PHONY: delete_api
delete_api:
	@echo "Deleting api-service ..."
	kubectl delete svc api-service
	@echo "Deleting api-deployment"
	kubectl delete deployment api-deployment

.PHONY: delete_all
delete_all: delete_debug_api delete_summation delete_api
	@echo "Cleaned up every thing ... :)"