DOCKER_HOST   := docker.io
DOCKER_USER := lchenn
ARTIFACT := maven-multi-stage-builder

FULL_NAME   := ${DOCKER_HOST}/${DOCKER_USER}/${ARTIFACT}
GIT_HASH    := $$(git log -1 --pretty=%h)
LATEST := latest
VERSION := 1.0.8

.PHONY: build push login initialize-development pre-commit

build:
	@docker build -t $(FULL_NAME):${GIT_HASH} .
	@docker tag $(FULL_NAME):${GIT_HASH} ${FULL_NAME}:${LATEST}
	@docker tag $(FULL_NAME):${GIT_HASH} ${FULL_NAME}:${VERSION}

push: login
	@docker push ${FULL_NAME}:${LATEST}
	@docker push ${FULL_NAME}:${VERSION}

login:
	@docker login --username $(DOCKER_USER) --password ${DOCKER_PASSWORD}

# Initialize the project development environment.
initialize-development:
	@pip install --upgrade pylint future pre-commit
	@pre-commit install

# Run pre-commit for all
pre-commit:
	@pre-commit run --all-files
