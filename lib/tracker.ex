defmodule Tracker do
    use GenServer
    def start_link do
        GenServer.start_link(__MODULE__,0,name: Timer)
    end
    
    def init(state) do
        
        {:ok, state}
     
    end
    def via_tuple(node_name) do
        {:via, MyRegistry, {:node_name, node_name}}
      end
    def get_count(pid) do
        :global.sync()
        GenServer.call(pid, :get_count)
    end
    def handle_call(:get_count, _from, state) do
        
        {:reply, state, state}
      end
    def handle_cast({:set_count,count}, state) do
        
        state = count
        {:noreply, state}
    end
end