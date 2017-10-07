defmodule Topologies do
    def rep do
        
       receive do {neigh,selfNode,id,algo,pid_tracker}-> 
        
        
        Enum.each neigh, fn next_neighbor-> 
           
            Manager.start_node(selfNode,neigh,next_neighbor,id,algo,pid_tracker) 
        end 
    end
    end
    
    def createLine(num,algo,pid_tracker) do
        neighbors = []
        pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end)
        Enum.each 0..num-1, fn id ->
            neigh = []
            selfNode = Enum.at(pids,id)
            if id==0 do
            
            neigh = [Enum.at(pids,id+1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker})
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker})
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(selfNode,{neigh,selfNode,id+1,algo,pid_tracker})
            end
            
            end
            neigh = []
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
        IO.inspect(pids)
        Enum.each 0..root-1, fn i ->
            
            Enum.each 0..root-1, fn j ->
                neigh = []
                count = (i*root) + j+1
                selfNode = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                   
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                   
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j+1) 
                    neigh = [rand|neigh]
                    
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (i==0 && j == root-1) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [rand|neigh]
                    
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                   
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (i == root-1 && j == 0) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j+1) 
                    neigh = [rand|neigh]
               
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (j==0) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j+1)
                    
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (i==0) do
                
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
                else
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    rand = Enum.at(Enum.at(pids,i-1),j+1)
                    neigh = [rand|neigh]
                    send(selfNode,{neigh, selfNode, count,algo,pid_tracker})
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

                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (i==0 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (i == root-1 && j == 0) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (j==0) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (i==0) do
             
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
                else
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, selfNode, count,algo,pid_tracker})
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
         list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        Enum.each 0..num-1, fn x ->
            pid = List.delete_at(pids, x)
            IO.inspect(pid)
            send(Enum.at(pids,x),{pid,Enum.at(pids,x) , x+1,algo,pid_tracker}) 
    end
end
end