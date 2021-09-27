-module(exame).
-compile(export_all).


start() -> 
    spawn(fun() -> partida() end).


timeout() -> 
    thread:sleep(200), 
    timeout ! ?MODULE:partida
end

partida() -> 
    ?MODULE:timeout(),
    receive
        timeout ->
            io:format("timeout atingido")
end





%partida(Pids) ->
%    % random valor =
%    % lista com jogadores []
%    receive
%        {jogador,adivinha,valor} ->
%            adivinha > valor,
%        
%            sdfsdf;
%        {Pid} ->
%            partida([Pid | Pids ]);
%        {timeout} -> 
%            [Timeout ! Pid || Pid <- Pids];
%        {Pid, ganhou} ->
%            % filtrar lista excepto vencedor
%            dicts:filter(Pid, Pids)
%            [Perdeu ! Pid || Pid <- Pids];
%



