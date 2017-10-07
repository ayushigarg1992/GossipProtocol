defmodule Lists do
    def start_link do
        GenServer.start_link(__MODULE__,[],name: Timer)
    end

    def init(list) do
        
        {:ok, list}
    
    end

    def get_list(pid) do
        :global.sync()
        GenServer.call(pid, :get_pids)
    end
    def handle_call(:get_pids, _from, list) do
        
        {:reply, list, list}
    end
    def handle_cast({:add_pid,item}, list) do
        update = [item|list]
        {:noreply, update}
    end
    def add_item(item,pid) do
    
    GenServer.cast(pid,{:add_pid,item})
    get_list(pid)
    end

end