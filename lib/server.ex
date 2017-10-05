defmodule Server do
  use GenServer
  def start_link(name,neigh,node,id) do
    
    GenServer.start_link(__MODULE__, {0,id,1,0,0,0,0,0},name: via_tuple(node))
    {count,s,w,ratio,pre1,pre2,prev3,diff} = get_state(node)
    if count<10 do
      send_rumor(neigh,name,"push",node)
    end
  end
  
  def init(state) do
    #state =  state
    {:ok, state}

  end
  
  def handle_cast({:add_message,algo,starter,me}, state) do
    {count,s,w,ratio,prev1,prev2,prev3,diff} = state
    if algo=="gossip" do  
      if  count<=10 do
        count = count+1
      else if count>=10 do Process.exit(self,:kill) end
      end
    else 
      
      if diff<0.00000000001 do
        IO.puts diff
        Process.exit(self,:kill)
      else
        
        
        prev1=prev2
        prev2=prev3
        prev3 = diff

        diff = ratio-s/w
        ratio = s/w
        s=s+s/2
        w=w+w/2

      end
    end  
    state = {count,s,w,ratio,prev1,prev2,prev3,diff}
    
    {:noreply, state}
  end
  
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
 
  def send_rumor(neigh,starter, algo,me) do
    chosen = Enum.random(neigh)
    GenServer.cast(via_tuple(chosen), {:add_message,algo,starter,me})
    {count,s,w,ratio,prev1,prev2,prev3,diff} = get_state(me)
    if algo == "gossip" do
      
      if(count<10) do
      send_rumor(neigh,starter,algo,me)
      else
        IO.puts "Node #{inspect me} has heard the rumor 10 times"
      end
    else
      
      if diff>0.0000000001 do
      send_rumor(neigh,starter,algo,me)
      else
        IO.puts "Node #{inspect me} has s: #{s} and w: #{w} and s/w is #{inspect s/w}"
      end
    end
   end
  
  def get_state(node_name) do
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end