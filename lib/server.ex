
defmodule Server do
  use GenServer
def start_link(name,neigh,node) do
    
    GenServer.start_link(__MODULE__, {},name: via_tuple(name))
    Enum.each neigh, fn i-> IO.puts " Node: #{inspect name} Neighbor: #{inspect i}" end
    #send_rumor(neigh,name,"gossip")
    
  end
  def init(state) do
    state =  {0,0,1}
    {:ok, state}

  end
  
  def handle_cast({:add_message,algo,starter}, state) do
    {count,s,w} = state
    IO.puts "count: #{count} s: #{s} w: #{w}"
    if algo=="gossip" do  
      if  count<=10 do
        
        count = count+1
        IO.inspect "My count is #{count} from #{inspect starter}"
      else if count>=10 do Process.exit(self,:kill)
        end
      end
    end  
    state = {count,s,w}
    
    {:noreply, state}
  end
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
 
  def send_rumor(neigh,starter, algo) do
    chosen = Enum.random(neigh)
    IO.inspect "I am the chosen node:#{inspect chosen} and the starter is #{inspect starter}"
    GenServer.cast(via_tuple(chosen), {:add_message,algo,starter})
    #send_rumor(neigh,starter,algo)
  end

  def get_node_state(node_name) do
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end