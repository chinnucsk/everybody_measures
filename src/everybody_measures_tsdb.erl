%% Feel free to use, reuse and abuse the code in this file.

-module(everybody_measures_tsdb).
-export([initialize_sqlite_db/1,
	 add_measure/4,
	 get_measures/2]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

-define(DB, test_db).
-define(FuncTest(Name), {??Name, fun Name/0}).

-endif.

initialize_sqlite_db(Conn) ->
    {ok, Data} = file:read_file(code:priv_dir(everybody_measures) ++ "/db/sqlite.sql"),
    [ok|_] = sqlite3:sql_exec_script(Conn, Data),
    ok.

add_measure(Conn, Table, Time, Value) ->
    {rowid, _} = sqlite3:write(Conn, Table, [{time, Time}, {value, Value}]),
    ok.

get_measures(Conn, Table) when is_atom(Table) ->
    [{columns,_},{rows, Rows}] = sqlite3:sql_exec(Conn, "SELECT * from "++atom_to_list(Table)),
    Rows.


%% ===================================================================
%% Tests
%% ===================================================================

-ifdef(TEST).

all_test_() ->
    {setup,
     fun open_db/0,
     fun close_db/1,
     [?FuncTest(test_initialize_sqlite_db),
      ?FuncTest(test_add_measure)]}.

test_initialize_sqlite_db() ->
    ok = initialize_sqlite_db(?DB).

test_add_measure() ->
    ok = initialize_sqlite_db(?DB),
    add_measure(?DB, integer_measures, 1, 37),
    add_measure(?DB, integer_measures, 2, 38),
    [{1,37}, {2,38}] = get_measures(?DB, integer_measures).


open_db() ->
    sqlite3:open(?DB, [in_memory]).

close_db({ok, _Pid}) ->
    sqlite3:close(?DB).

-endif.

%% Eof
