-module(everybody_measures_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    everybody_measures_sup:start_link().

stop(_State) ->
    ok.


%% ===================================================================
%% Tests
%% ===================================================================

-ifdef(TEST).

simple_test() ->
    ok = error_logger:tty(false),
    ok = error_logger:logfile({open, "error_logger.log"}),

    ok = application:start(everybody_measures),
    ?assert(is_pid(whereis(everybody_measures_sup))),
    ok = application:stop(everybody_measures).

-endif.

%% Eof
