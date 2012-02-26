
-module(everybody_measures_http_handler).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Req2} = log_req(Req),
    case cowboy_http_req:path(Req2) of
	{[<<"hello">>], Req3} ->
	    {ok, Req4} = cowboy_http_req:reply(200, [], <<"Hello world2!">>, Req3);
	{[<<"hello.txt">>, <<"foo">>], Req3} ->
	    {ok, Req4} = cowboy_http_req:reply(200, [], <<"Hello world3!">>, Req3);
	_ ->
	    {ok, Req4} = cowboy_http_req:reply(200, [], <<"Everybody Measures - comming real soon...">>, Req)
    end,
    {ok, Req4, State}.

terminate(_Req, _State) ->
    ok.

log_req(Req)->
    {Method, Req2}    = cowboy_http_req:method(Req),
    {Peer, Req3}      = cowboy_http_req:peer(Req2),
    {Peer_addr, Req4} = cowboy_http_req:peer_addr(Req3),
    {Host, Req5}      = cowboy_http_req:host(Req4),
    {Host_info, Req6} = cowboy_http_req:host_info(Req5),
    {Port, Req7}      = cowboy_http_req:port(Req6),
    {Path, Req8}      = cowboy_http_req:path(Req7),
    {Path_info, Req9} = cowboy_http_req:path_info(Req8),
    {Qs_vals, Req10}  = cowboy_http_req:qs_vals(Req9),
    error_logger:info_msg("Request ~p~n", [[{method, Method},{peer, Peer},{peer_addr, Peer_addr},{host, Host},{host_info, Host_info},{port, Port},{path, Path},{path_info, Path_info},{qs_vals, Qs_vals}]]),
    {ok, Req10}.
