
test:
	./rebar eunit skip_deps=true

test-log:
	cat .eunit/error_logger.log

compile:
	./rebar compile skip_deps=true

all: dependencies

dependencies:
	./rebar get-deps update-deps compile

clean: clean-emacs
	./rebar clean

clean-emacs:
	find . -name '*~' | xargs rm -f