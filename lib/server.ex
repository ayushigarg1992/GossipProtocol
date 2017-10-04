
defmodule Server do
  use GenServer
def start_link(name,neigh) do
    
    GenServer.start_link(__MODULE__, {},name: via_tuple(name))
    chosen = Enum.random(neigh)
    send_rumor(chosen,name,"gossip")
  end
  def init(state) do
    state =  {0,0,1}
    {:ok, state}

  end
  
  def handle_cast({:add_message,algo,starter}, state) do
    {count,s,w} = state
    IO.puts "count: #{count} s: #{s} w: #{w}"
    if algo == "gossip" do
      
      count = count+1
    
    else
    end
    state = {count,s,w}
    IO.inspect "My count is #{count} from #{inspect starter}"
    {:noreply, state}
  end
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
 
  def send_rumor(node_name,starter, algo) do
    
    GenServer.cast(via_tuple(node_name), {:add_message,algo,starter})
  end
  def get_node_state(node_name) do
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end