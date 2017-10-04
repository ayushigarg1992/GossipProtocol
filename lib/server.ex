# in lib/chat/server.ex
defmodule Server do
  use GenServer
def start_link(name) do
    
    GenServer.start_link(__MODULE__, {},name: via_tuple(name))
  end
  def init(state) do
    state =  {0,0,1}
    {:ok, state}

  end
  
  def handle_cast({:add_message,algo}, state) do
    {count,s,w} = state
    IO.puts "count: #{count} s: #{s} w: #{w}"
    if algo == "gossip" do
      
      count = count+1
    
    else
    end
    state = {count,s,w}
    {:noreply, state}
  end
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
 
  def send_rumor(node_name, algo) do
    
    GenServer.cast(via_tuple(node_name), {:add_message,algo})
  end
  def get_node_state(node_name) do
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end