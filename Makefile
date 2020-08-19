.PHONY : amd
amd:
	@docker build --squash --secret id=password,src=./password.txt -t \
	yrivero/timemachine:1.0.0 -f Dockerfile.amd64 .

.PHONY : arm
arm:
	@docker build --squash --secret id=password,src=./password.txt -t \
	yrivero/timemachine:1.0.0 -f Dockerfile.amd64 .
