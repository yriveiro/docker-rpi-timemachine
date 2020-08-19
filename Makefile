.PHONY : build
build:
	@docker build --squash --secret id=password,src=./password.txt -t yriveiro/timemachine:1.0.0 .
