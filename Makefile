
test:
	./rebar eunit skip_deps=true

test-log:
	cat .eunit/error_logger.log

compile:
	./rebar compile skip_deps=true

all: dependencies

dependencies: create-log-dir
	./rebar get-deps update-deps compile

create-log-dir:
	mkdir -p log

clean: clean-emacs
	./rebar clean

clean-emacs:
	find . -name '*~' | xargs rm -f