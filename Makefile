DOCKER_HOST   := docker.io
DOCKER_ID_USER := lchenn
ARTIFACT := docker-maven-multi-stage-builder

FULL_NAME   := ${DOCKER_HOST}/${DOCKER_ID_USER}/${ARTIFACT}
GIT_HASH    := $$(git log -1 --pretty=%h)
LATEST := latest
VERSION := 1.0.1

.PHONY: build push login

build:
	@docker build -t $(ARTIFACT):${GIT_HASH} .
	@docker tag $(ARTIFACT):${GIT_HASH} ${FULL_NAME}:${LATEST}
	@docker tag $(ARTIFACT):${GIT_HASH} ${FULL_NAME}:${VERSION}

push: login
	docker push ${FULL_NAME}:${LATEST}
	docker push ${FULL_NAME}:${VERSION}

login:
	@docker login --username $(DOCKER_ID_USER) --password $(DOCKER_ID_PASSWORD)

