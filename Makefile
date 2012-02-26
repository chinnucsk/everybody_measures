
test:
	rm -f .eunit/log/*
	./rebar eunit skip_deps=true

test-log:
	cat .eunit/log/info.log

compile:
	./rebar compile skip_deps=true

deps: dependencies

all: dependencies

dependencies: create-log-dir
	./rebar get-deps update-deps compile

create-log-dir:
	mkdir -p log
	touch log/everybody_measures.log

clean: clean-emacs
	./rebar clean

clean-emacs:
	find . -name '*~' | xargs rm -f

rm-logs:
	rm log/*
