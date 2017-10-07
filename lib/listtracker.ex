defmodule Lists do
    def start_link do
        GenServer.start_link(__MODULE__,[],name: Listlist)
    end

    def init(list) do
        
        {:ok, list}
    
    end

    def get_list(pid) do
        :global.sync()
        GenServer.call(pid, :get_pids)
    end
    def handle_call(:get_pids, _from, list) do
        IO.puts("handle_call list is #{inspect list}")
        {:reply, list, list}
    end
    def handle_cast({:add_pid,item}, list) do
        if (Enum.member?(list,item)) do
        else
        list = [item|list]
        end
        IO.puts(" handle_cast list is #{inspect list}")
        {:noreply, list}
    end
    def add_item(item,pid) do
    
    GenServer.cast(pid,{:add_pid,item})
    get_list(pid)
    end

end