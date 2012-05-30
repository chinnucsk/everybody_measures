%% @author author <author@example.com>
%% @copyright YYYY author.
%% @doc Example webmachine_resource.

-module(everybody_measures_resource).
-export([init/1, to_html/2]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>", ReqData, State}.


%% ===================================================================
%% Tests
%% ===================================================================

-ifdef(TEST).

tete_test() ->
    53.

-endif.

%% Eof
