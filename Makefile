
test:
	./rebar eunit skip_deps=true

test-log:
	cat .eunit/error_logger.log

compile:
	./rebar compile skip_deps=true

dependencies:
	./rebar get-deps update-deps compile
