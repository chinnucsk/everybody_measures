
-module(everybody_measures_http_handler).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    ok = lager:info("Request: ~p", [Req]),
    case cowboy_http_req:path(Req) of
	{[<<"hello">>], Req2} ->
	    {ok, Req3} = cowboy_http_req:reply(200, [], <<"Hello world2!">>, Req2);
	{[<<"hello.txt">>, <<"foo">>], Req2} ->
	    {ok, Req3} = cowboy_http_req:reply(200, [], <<"Hello world3!">>, Req2);
	{_, Req2} ->
	    {ok, Req3} = cowboy_http_req:reply(200, [], <<"Everybody Measures - comming real soon...">>, Req2)
    end,
    {ok, Req3, State}.

terminate(_Req, _State) ->
    ok.
