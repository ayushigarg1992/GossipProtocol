defmodule Server do
  use GenServer
  def start_link(selfNode,neigh,next_neighbor,id) do
    GenServer.start_link(__MODULE__, {0,id,1,0,0,0,0,0},name: via_tuple(next_neighbor))
    
<<<<<<< HEAD
    {ok, p} = GenServer.start_link(__MODULE__, {0,id,1,0,0,0,0,0},name: via_tuple(node))
   
    {count,s,w,ratio,pre1,pre2,prev3,diff} = get_state(node)
    if count<10 do
      send_rumor(neigh,name,"gossip",node)
=======
    {count,s,w,ratio,pre1,pre2,prev3,diff} = get_state(next_neighbor)
    if count<10 do
      
      send_rumor(neigh,selfNode,"push",next_neighbor)
>>>>>>> 0aae66e5ecef1b94aab55844826c1e8eec0e63b1
    end
  end
  
  def init(state) do
   # IO.puts "#{inspect state}"
    
    stateup =  state

    {:ok, stateup}

  end

  
  def handle_cast({:add_message,algo,self_node,next_neighbor}, state) do
    
    #IO.puts "#{inspect get_state(next_neighbor)}"
    {count,s,w,ratio,prev1,prev2,prev3,diff} = state
    if algo=="gossip" do  
      if  count<=10 do
        count = count+1
      else if count>=10 do Process.exit(self,:kill) end
      end
    else 
      
      if diff<0.00000000001 do
        Process.exit(self,:kill)
      else if algo=="push" do
        
        
        prev1=prev2
        prev2=prev3
        prev3 = diff

        s=s/2
        w=w/2
        diff = ratio-s/w
<<<<<<< HEAD
        ratio = s/w

=======
       
        s=s+s/2
        w=w+w/2
        ratio = s/w
>>>>>>> 0aae66e5ecef1b94aab55844826c1e8eec0e63b1
      end
    end
    end  
    state = {count,s,w,ratio,prev1,prev2,prev3,diff}
    
    {:noreply, state}
  end
  
  def handle_call(:get_state, _from, state) do
    
    {:reply, state, state}
  end
 
  def send_rumor(neigh,self_node, algo,next_neighbor) do
    chosen = Enum.random(neigh)
<<<<<<< HEAD
    #GenServer.cast(via_tuple(starter), {:update_message,algo,starter,me})
    GenServer.cast(via_tuple(chosen), {:add_message,algo,starter,me})
    {count,s,w,ratio,prev1,prev2,prev3,diff} = get_state(me)
=======
    
    GenServer.cast(via_tuple(chosen), {:add_message,algo,self_node,next_neighbor})
    {count,s,w,ratio,prev1,prev2,prev3,diff} = get_state(next_neighbor)
>>>>>>> 0aae66e5ecef1b94aab55844826c1e8eec0e63b1
    if algo == "gossip" do
      
      if(count<10) do
     
      send_rumor(neigh,self_node,algo,next_neighbor)
      else
<<<<<<< HEAD
        IO.puts " s = #{inspect s} w =#{inspect w} Node #{inspect me} has heard the rumor 10 times"
=======
        IO.puts "Node #{inspect next_neighbor} has heard the rumor 10 times"
>>>>>>> 0aae66e5ecef1b94aab55844826c1e8eec0e63b1
      end
    else
      
      if diff>0.0000000001 do
<<<<<<< HEAD
      # call a cadt function here to reset me's state with s/2 and w/2
      send_rumor(neigh,starter,algo,me)
=======
        
      send_rumor(neigh,self_node,algo,next_neighbor)
>>>>>>> 0aae66e5ecef1b94aab55844826c1e8eec0e63b1
      else
        IO.puts "Node #{inspect next_neighbor} has s: #{s} and w: #{w} and s/w is #{inspect s/w}"
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