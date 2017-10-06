defmodule Topologies do
    def rep do
       receive do {neigh,me,id}-> 
            Enum.each neigh, fn node-> 
            Manager.start_node(me,neigh,node,id) 
            
        end 
    end
    end
    
    def createLine(num) do
        neighbors = []
        pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end)
        Enum.each 0..num-1, fn id ->
            neigh = []
            me = Enum.at(pids,id)
            if id==0 do
            
            neigh = [Enum.at(pids,id+1)]
            send(me,{neigh,me,id})
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(me,{neigh,me,id})
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(me,{neigh,me,id})
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
        IO.inspect(pids)
        Enum.each 0..root-1, fn i ->
            
            Enum.each 0..root-1, fn j ->
                neigh = []
                count = (i*root) + j+1
                me = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                   
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                   
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j+1) 
                    neigh = [rand|neigh]
                    
                    send(me,{neigh, me, count})
                else if (i==0 && j == root-1) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [rand|neigh]
                    
                    send(me,{neigh, me, count})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                   
                    send(me,{neigh, me,count})
                else if (i == root-1 && j == 0) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j+1) 
                    neigh = [rand|neigh]
               
                    send(me,{neigh, me, count})
                else if (j==0) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j+1)
                    
                
                    send(me,{neigh, me, count})
                else if (i==0) do
                
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i+1),j-1) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me, count})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me, count})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = Enum.at(Enum.at(pids,i-1),j-1) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me, count})
                else
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    rand = Enum.at(Enum.at(pids,i-1),j+1)
                    neigh = [rand|neigh]
                    send(me,{neigh, me, count}) 
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
               
                me = Enum.at(Enum.at(pids,i),j)
                
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (i==0 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (i == root-1 && j == root-1) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (i == root-1 && j == 0) do
               
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (j==0) do
              
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (i==0) do
             
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (i==root-1) do
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else if (j==root-1) do
                
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count})
                else
              
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me, count}) 
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

    def createFull(num) do
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        
    end
end