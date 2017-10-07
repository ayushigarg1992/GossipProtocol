defmodule Server do
  use GenServer
  def start_link(selfNode,neigh,next_neighbor,id,algo,pid_tracker,num) do
    GenServer.start_link(__MODULE__, {0,id,1,0,0,0,0,0},name: via_tuple(next_neighbor))
    
    {count,s,w,ratio,pre1,pre2,prev3,diff} = get_state(next_neighbor)
    if count<10 do
      
      send_rumor(neigh,selfNode,algo,next_neighbor,pid_tracker,num)
    end
  end
  
  def init(state) do
   # IO.puts "#{inspect state}"
    
    stateup =  state

    {:ok, stateup}

  end
  
  def handle_cast({:add_message,algo,self_node,next_neighbor,pid_tracker,num}, state) do
    
    #IO.puts "#{inspect get_state(next_neighbor)}"
    if Process.alive?(self_node) do
    {_,s2,w2,_,_,_,_,_} = get_state(self_node) 
    {count,s,w,ratio,prev1,prev2,prev3,diff} = state
    if algo=="gossip" do  
      if  count<=10 do
        count = count+1
      else if count>=10 do 
        IO.puts "Node #{inspect next_neighbor} has heard the rumor 10 times and converged"
        {counter,_} = Tracker.get_count(pid_tracker)
         GenServer.cast(pid_tracker,{:set_count,counter+1,num})
        Process.exit(self,:kill) 
      end
      end
    else 
      ratio2 = ratio
      s=s+s2/2
      w=w + w2/2
      ratio = s/w
      diff = ratio - ratio2
      prev3=prev2
      prev2=prev1
      prev1=ratio2
      lim=0.0000000001
      
      statement =  abs(prev1-prev2)<=lim && abs(prev2-prev3)<=lim
      if statement do
        IO.puts "Node #{inspect self_node} s/w: #{inspect ratio} s:#{inspect s} w:#{inspect w} "
        
         IO.puts(" #{inspect self_node}- I have converged")
         :global.sync
         {count,_} = Tracker.get_count(pid_tracker)
         GenServer.cast(pid_tracker,{:set_count,count+1,num})
       else
        IO.puts "Node #{inspect self_node} s/w: #{inspect ratio} s:#{inspect s} w:#{inspect w} "
       end   
      end
    
    state = {count,s,w,ratio,prev1,prev2,prev3,diff}
    
  end
    {:noreply, state}
  end
  
  def handle_call(:get_state, _from, state) do
    
    {:reply, state, state}
  end
 
  def send_rumor(neigh,self_node, algo,next_neighbor,pid_tracker,num) do
    chosen = Enum.random(neigh)
    {count,s,w,ratio,prev1,prev2,prev3,diff} = get_state(self_node)
    s=s/2
    w=w/2
    state = {count,s,w,ratio,prev1,prev2,prev3,diff}
    :global.sync()
    GenServer.cast(via_tuple(chosen), {:add_message,algo,self_node,next_neighbor,pid_tracker,num})
    {count,s,w,ratio,prev1,prev2,prev3,diff} = get_state(next_neighbor)
    if algo == "gossip" do
      
      if(count<10) do
     
      send_rumor(neigh,self_node,algo,next_neighbor,pid_tracker,num)
      else
       
      end
    else
      lim=0.0000000001
      statement =  abs(prev1-prev2)>=lim && abs(prev2-prev3)>=lim#(prev1 != 0 && prev1 <= lim) && (prev2 != 0 && prev2 <= lim) && (prev3 != 0 && prev3 <= lim)
      if !statement do
      Process.sleep(Enum.random(0..1000))
      send_rumor(neigh,self_node,algo,next_neighbor,pid_tracker,num)
      else
      end
    end
   end
  
  def get_state(node_name) do
    :global.sync()
    GenServer.call(via_tuple(node_name), :get_state)
  end
  def via_tuple(node_name) do
    {:via, MyRegistry, {:node_name, node_name}}
  end
end