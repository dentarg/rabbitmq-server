%% The contents of this file are subject to the Mozilla Public License
%% Version 1.1 (the "License"); you may not use this file except in
%% compliance with the License. You may obtain a copy of the License
%% at http://www.mozilla.org/MPL/
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and
%% limitations under the License.
%%
%% The Original Code is RabbitMQ.
%%
%% The Initial Developer of the Original Code is GoPivotal, Inc.
%% Copyright (c) 2016 GoPivotal, Inc.  All rights reserved.
%%

-module(rabbit_web_mqtt_middleware).
-behavior(cowboy_middleware).

-export([execute/2]).

execute(Req, Env) ->
    {keepalive_sup, KeepaliveSup} = lists:keyfind(keepalive_sup, 1, Env),
    case lists:keyfind(handler_opts, 1, Env) of
        {_, Opts} when is_list(Opts) ->
            {ok, Req, lists:keyreplace(handler_opts, 1, Env,
                {handler_opts, [{keepalive_sup, KeepaliveSup}|Opts]})};
        _ ->
            {ok, Req, Env}
    end.
