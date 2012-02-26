%% Feel free to use, reuse and abuse the code in this file.

-module(everybody_measures).
-export([start/0, stop/0]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

start() ->
    ok = error_logger:tty(false),
    ok = ensure_started(lager),
    timer:sleep(10),
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
    ok = application:stop(crypto),
    timer:sleep(10),
    ok = application:stop(lager).

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
    error_logger:tty(false),
    ok = application:load(lager),
    application:set_env(lager,  handlers,  [{lager_file_backend, [{"log/error.log", error, 0, "", 0},
								  {"log/info.log", info, 0, "", 0}]}]),
    ok = application:start(lager),
    ok = ?MODULE:start(),
    ?assert(is_pid(whereis(everybody_measures_sup))),
    ok = ?MODULE:stop().

-endif.

%% Eof
