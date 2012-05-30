%% Feel free to use, reuse and abuse the code in this file.

-module(everybody_measures).
-export([start/0, stop/0]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

start() ->
    ok = error_logger:tty(false),
    ok = ensure_started(syntax_tools),
    ok = ensure_started(compiler),
    ok = ensure_started(lager),
    ok = ensure_started(crypto),
    ok = ensure_started(public_key),
    ok = ensure_started(ssl),
    ok = ensure_started(inets),
    ok = ensure_started(mochiweb),
    ok = ensure_started(webmachine),
    ok = ensure_started(everybody_measures).

stop() ->
    Res = application:stop(everybody_measures),
    ok = application:stop(webmachine),
    ok = application:stop(mochiweb),
    ok = application:stop(inets),
    ok = application:stop(ssl),
    ok = application:stop(public_key),
    ok = application:stop(crypto),
    ok = application:stop(lager),
    ok = application:stop(syntax_tools),
    ok = application:stop(compiler),
    Res.

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

%% -ifdef(TEST).
%%
%% configure_and_start_larger() ->
%%     ok = error_logger:tty(false),
%%     ok = application:load(lager),
%%     ok = application:set_env(lager,  handlers,  [{lager_file_backend, [{"log/error.log", error, 0, "", 0},
%% 								       {"log/info.log", info, 0, "", 0}]}]),
%%     ok = ensure_started(syntax_tools),
%%     ok = ensure_started(compiler).
%%
%% start_stop_test() ->
%%     configure_and_start_larger(),
%%     ok = ?MODULE:start(),
%%     ?assert(is_pid(whereis(everybody_measures_sup))),
%%     timer:sleep(1000),
%%     ok = ?MODULE:stop().
%%
%% -endif.

%% Eof
