.PHONY: build push

IMAGE_NAME = odk-ai
TAG = latest

#BUILD_OPTS = --no-cache
BUILD_OPTS = 

build:
	docker build $(BUILD_OPTS) -t $(IMAGE_NAME):$(TAG) .

push: build
	docker tag $(IMAGE_NAME):$(TAG) cjmungall/$(IMAGE_NAME):$(TAG)
	docker push cmungall/$(IMAGE_NAME):$(TAG)

run:
	docker run -it --rm $(IMAGE_NAME):$(TAG)
