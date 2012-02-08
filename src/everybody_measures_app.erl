-module(everybody_measures_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_Type, _Args) ->
    Dispatch = [{'_', [{'_', everybody_measures_http_handler, []}]}],

    cowboy:start_listener(everybody_measures_http_listener, 100,
			  cowboy_tcp_transport, [{port, 8080}],
			  cowboy_http_protocol, [{dispatch, Dispatch}]),

    everybody_measures_sup:start_link().

stop(_State) ->
    ok.
