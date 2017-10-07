defmodule Topologies do
    use GenServer
    def rep do
        
       receive do {neigh,selfNode,id,algo,pid_tracker,num,list_pid,time}-> 
                    list = Lists.get_list(list_pid)
           
        Enum.each neigh, fn item-> 
           if (Enum.member?(list,item)) do
           else 
            :global.sync()
            GenServer.cast(list_pid,{:add_pid,item})
            Manager.start_node(selfNode,neigh,item,id,algo,pid_tracker,num,time)
            
             
            
        end 
        end
    end
    end
    

   

  def via_tuple(node_name) do
        IO.inspect(node_name)
        IO.puts("via tuple")
    {:via, MyRegistry, {:node_name, node_name}}
  end

  
    
    def createLine(num, algo, pid_tracker) do
        neighbors = []
        pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end)
        time = :os.system_time(:milli_seconds)
        {:ok,list_pid} = Lists.start_link
        Enum.each 0..num-1, fn id ->
            neigh = []
            selfNode = Enum.at(pids,id)
            if id==0 do
            
            neigh = [Enum.at(pids,id+1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker,num,list_pid,time})
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker,num,list_pid,time})
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker,num,list_pid,time})
            end
            
            end
            neigh = []
        end
          
    end


        def chooseRandom(root,pids,neigh,selfNode) do
            rand1 = Enum.random(0..root-1)
             rand2 = Enum.random(0..root-1)
            rand = Enum.at(Enum.at(pids,rand1),rand2)
                if (rand == selfNode || Enum.member?(neigh,rand)) do
                    chooseRandom(root,pids,neigh,selfNode)
                else
                    rand
                end


        end
            

        def createImpGrid(num,algo,pid_tracker) do
        neighbor=[]
        list = []
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
                time = :os.system_time(:milli_seconds)
                
       
       {:ok,list_pid} = Lists.start_link
        Enum.each 0..root-1, fn i ->
            
            Enum.each 0..root-1, fn j ->
                neigh = []
                count = (i*root) + j+1
                selfNode = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                   
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                   
                    neigh = [pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==0 && j == root-1) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                   
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    rand = Enum.at(Enum.at(pids,i-1),j-1)
                    neigh = [pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                                       
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i == root-1 && j == 0) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
               
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (j==0) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh= [pid,pid1,pid0]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==0) do
                
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid,pid1,pid0,pid2]
                    rand = chooseRandom(root,pids,neigh,selfNode)
                    
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
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

    def createGrid(num,algo,pid_tracker) do
   neighbor=[]
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
       
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
        
                time = :os.system_time(:milli_seconds)
                
        {:ok,list_pid} = Lists.start_link
        Enum.each 0..root-1, fn i ->
            Enum.each 0..root-1, fn j ->
                neigh = []
               count = (i*root) + j+1
                selfNode = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    #                    send(selfNode,{neigh, selfNode, count,algo})

                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==0 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i == root-1 && j == 0) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (j==0) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==0) do
             
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
                else
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker,num,list_pid,time})
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
    
    def test_func(list1,list2,i,num) do
        
        if Enum.at(list1,i) !=num do
        list2 = [Enum.at(list1,i)|list2]
        
        end
        if i+1< length list1 do
            
            list3 = list2
            test_func(list1,list2,i+1,num)
        
        IO.puts "list2: #{inspect list2} list3: #{inspect list3}"
        end
        
    end
    def test_2 do
        list1=[1,2,3,4,5,67,7,8,6,5,4,4]
        
        pid= Enum.at(list1,7)
        IO.inspect(pid)
        list2 = []
        
        list = test_func(list1,list2,0,pid)
        IO.puts "I am #{inspect list}"
    end
    def createFull(num,algo,pid_tracker) do
         pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end )
         time = :os.system_time(:milli_seconds)
         
         {:ok,list_pid} = Lists.start_link
        Enum.each 0..num-1, fn x ->
            pid = List.delete_at(pids, x)
            
            send(Enum.at(pids,x),{pid,Enum.at(pids,x) , x+1,algo,pid_tracker,num,list_pid}) 
    end
end
end