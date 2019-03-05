PROGRAM = repository-bot

ID = $(shell id -u)
PWD = $(shell pwd)

container:
	@docker build \
		--build-arg USER_ID=$(ID) \
		--build-arg TRAVIS=$(TRAVIS) \
		--build-arg TOKEN=$(GITHUB_TOKEN) \
		--quiet --tag=$(PROGRAM) ./

run:
	@docker run \
		--volume="$(PWD)":/home/bot/remote \
		--init --tty $(PROGRAM) \
		python bot build

test:
	@docker run \
		--volume="$(PWD)":/home/bot/remote \
		--init --tty $(PROGRAM) \
		python bot validate

.PHONY: container test run
