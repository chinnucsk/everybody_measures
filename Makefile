
all:
	./rebar eunit skip_deps=true

compile:
	./rebar compile skip_deps=true

dependencies:
	./rebar get-deps update-deps compile
