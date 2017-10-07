defmodule Tracker do
    use GenServer
    def start_link(num) do
        GenServer.start_link(__MODULE__,{0,num,0},name: Timer)
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
        {counter,num,_} = state
        {:reply, state, state}
      end
    def handle_cast({:set_count,counter,num,time}, state) do
        state = {counter,num,time}
        percent = (counter/num)*100
        inittime = time
        convtime = :os.system_time(:milli_seconds) 
        diff = (convtime-inittime)
        IO.puts "#{percent} percent converged in #{diff} milliseconds"
        {:noreply, state}
    end
end