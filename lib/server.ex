defmodule Server do
  use GenServer
def start_link(name,neigh,node) do
    
    GenServer.start_link(__MODULE__, {},name: via_tuple(node))
    {count,s,w} = get_state(node)
    if count<10 do
    send_rumor(neigh,name,"gossip",node)
    end
  end
  def init(state) do
    state =  {0,0,1}
    {:ok, state}

  end
  
  def handle_cast({:add_message,algo,starter,me}, state) do
    {count,s,w} = state
    if algo=="gossip" do  
      if  count<=10 do
        
        count = count+1
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
 
  def send_rumor(neigh,starter, algo,me) do
    chosen = Enum.random(neigh)
    GenServer.cast(via_tuple(chosen), {:add_message,algo,starter,me})
    {count,s,w} = get_state(me)
    if(count<10) do
    send_rumor(neigh,starter,algo,me)
    else
      IO.puts "Node #{inspect me} has heard the rumor 10 times"
    end
  end
  
  def get_state(node_name) do
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end