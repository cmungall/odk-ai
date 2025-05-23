.PHONY: build push

IMAGE_NAME = odk-ai
TAG = latest

#BUILD_OPTS = --no-cache
BUILD_OPTS = 

build:
	@if [ -z "$$GH_TOKEN" ]; then \
		echo "ERROR: GH_TOKEN environment variable is not set"; \
		echo "Please set it with: export GH_TOKEN=your_github_token"; \
		echo "You can create a token at https://github.com/settings/tokens"; \
		exit 1; \
	fi
	docker build $(BUILD_OPTS) --build-arg GH_TOKEN=$(GH_TOKEN) -t cmungall/$(IMAGE_NAME):$(TAG) .

push: build
	docker tag $(IMAGE_NAME):$(TAG) cmungall/$(IMAGE_NAME):$(TAG)
	docker push cmungall/$(IMAGE_NAME):$(TAG)

run:
	docker run -it --rm $(IMAGE_NAME):$(TAG)

test:
	cd scratch && docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$$ANTHROPIC_API_KEY -it --rm odk-ai:latest bash

# e.g. test-repos/obophenotype/uberon
# git clone https://github.com/obophenotype/uberon
test-repos/%:
	cd test-repos && git clone https://github.com/$*
	
	
	
	
