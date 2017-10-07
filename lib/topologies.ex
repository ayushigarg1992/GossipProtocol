defmodule Topologies do
    use GenServer
    def rep do
        
       receive do {neigh,selfNode,id}-> 
       IO.inspect(selfNode)
        list = get_state(selfNode)
        IO.puts("hio")
        Enum.each neigh, fn next_neighbor-> 
            if (Enum.member?(list, next_neighbor)) do
               IO.puts("hiiiii")
            else 
               IO.puts("h")
                Manager.start_node(selfNode,neigh,next_neighbor,id) 
                GenServer.cast(via_tuple(next_neighbor), {:pids,next_neighbor,selfNode})
        end 
    end
    end
    end

    def start_link() do
    GenServer.start_link(__MODULE__, [] ,name: :server )
    
    
  end

  def init(state) do
    
    stateup =  state

    {:ok, stateup}

  end

  def handle_cast({:pids, next_neighbor,selfNode}, state) do
        list = state
            list = [next_neighbor| list]
            IO.puts("hi")
        state = list
    
    {:noreply, state}
  end
  
  def handle_call(:get_state, _from, state) do
    IO.puts("pooja")
    {:reply, state, state}
  end
 
  
  def get_state(node_name) do
    :global.sync()
    IO.puts("hioo")
    IO.inspect(node_name)
    GenServer.call(node_name, :get_state)
  end
  def via_tuple(node_name) do
        IO.inspect(node_name)
        IO.puts("poo")
    {:via, MyRegistry, {:node_name, node_name}}
  end

  
    
    def createLine(num) do
        neighbors = []
        pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end)
        
        Enum.each 0..num-1, fn id ->
            neigh = []
            selfNode = Enum.at(pids,id)
            if id==0 do
            
            neigh = [Enum.at(pids,id+1)]
            
            send(selfNode,{neigh,selfNode,id+1})
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(selfNode,{neigh,selfNode,id+1})
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(selfNode,{neigh,selfNode,id+1})
            end
            
            end
            neigh = []
        end
          
    end



        def createImpGrid(num) do
        neighbor=[]
        list = []
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
       
        Enum.each 0..root-1, fn i ->
            
            Enum.each 0..root-1, fn j ->
                neigh = []
                count = (i*root) + j+1
                selfNode = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                   
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                   rand = Enum.at(Enum.at(pids,i+1),j+1)
                    neigh = [pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else if (i==0 && j == root-1) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [pid1,pid,rand]
                    
                    send(selfNode,{neigh, selfNode, count})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i-1),j-1)
                    neigh = [pid1,pid,rand]
                   
                    send(selfNode,{neigh, selfNode,count})
                else if (i == root-1 && j == 0) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    rand = Enum.at(Enum.at(pids,i-1),j+1)
                    neigh = [pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else if (j==0) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    rand = Enum.at(Enum.at(pids,i+1),j+1)
                    neigh = [pid0,pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else if (i==0) do
                
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                     rand = Enum.at(Enum.at(pids,i+1),j-1)
                    neigh = [pid0,pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i-1),j-1)
                    neigh = [pid0,pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [pid0,pid1,pid,rand]
                    send(selfNode,{neigh, selfNode, count})

                else
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    rand = Enum.at(Enum.at(pids,i-1),j+1)
                    neigh = [pid0,pid1,pid,pid2,rand]
                    send(selfNode,{neigh, selfNode, count})

                end
                end
            end
        end
        end
    end
    end
    end
    end
    end
    end

    def createGrid(num) do
   neighbor=[]
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
       
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
        
        

        Enum.each 0..root-1, fn i ->
            Enum.each 0..root-1, fn j ->
                neigh = []
               count = (i*root) + j+1
                selfNode = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (i==0 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (i == root-1 && j == 0) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (j==0) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (i==0) do
             
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count})
                else
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count}) 
                end
                end
            end
        end
        end
    end
    end
    end
    end
    end
    end
    
   
    def createFull(num,algo) do
         pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end )
         
        Enum.each 0..num-1, fn x ->
            pid = List.delete_at(pids, x)
            
            send(Enum.at(pids,x),{pid,Enum.at(pids,x) , x+1,algo}) 
    end
end
end