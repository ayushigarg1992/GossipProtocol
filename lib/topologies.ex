defmodule Topologies do
    def rep do
       receive do {neigh,me}-> 
            Enum.each neigh, fn node->   
            Manager.start_node(me,neigh,node) 
            
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
            send(me,{neigh,me})
            IO.puts "I am #{inspect Enum.at(pids,id)} and neighbor is #{inspect Enum.at(pids,id+1)}"
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(me,{neigh,me})
            IO.puts "I am #{inspect Enum.at(pids,id)} and neighbor is #{inspect Enum.at(pids,id-1)}"
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(me,{neigh,me})
            IO.puts "I am #{inspect Enum.at(pids,id)} and neighbor is #{inspect Enum.at(pids,id+1)}, and #{inspect Enum.at(pids,id-1)}"
            end
            
            end
            neigh = []
        end
          
    end

        def chooseRandom(neigh, pid,pids) do
           rand = Enum.random(pids)
           if (rand == pid || Enum.member?(neigh, rand) ) do
              chooseRandom(neigh,pid,pids)
            else rand
            end
               
        end

        def createImpGrid(num) do
        neighbor=[]
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
        
        for i <- 0..root-1 do
            for j <- 0..root-1 do
                neigh = []
                me = Enum.at(Enum.at(pids,i),j)
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me}) 
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
        
        for i <- 0..root-1 do
            for j <- 0..root-1 do
                neigh = []
                me = Enum.at(Enum.at(pids,i),j)
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me}) 
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