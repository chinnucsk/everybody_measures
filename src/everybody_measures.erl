%% Feel free to use, reuse and abuse the code in this file.

-module(everybody_measures).
-export([start/0, stop/0]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

start() ->
    ok = ensure_started(crypto),
    ok = ensure_started(public_key),
    ok = ensure_started(ssl),
    ok = ensure_started(cowboy),
    ok = ensure_started(everybody_measures).

stop() ->
    ok = application:stop(everybody_measures),
    ok = application:stop(cowboy),
    ok = application:stop(ssl),
    ok = application:stop(public_key),
    ok = application:stop(crypto).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% ===================================================================
%% Tests
%% ===================================================================

-ifdef(TEST).

start_stop_test() ->
    ok = error_logger:tty(false),
    ok = error_logger:logfile({open, "error_logger.log"}),

    ok = ?MODULE:start(),
    ?assert(is_pid(whereis(everybody_measures_sup))),
    ok = ?MODULE:stop().

-endif.

%% Eof
