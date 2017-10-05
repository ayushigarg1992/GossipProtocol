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
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)]
            send(me,{neigh,me})
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)]
            send(me,{neigh,me})
            end
            
            end
            neigh = []
        end
          
    end

        def chooseRandom(neigh, pid,pids) do
           rand = Enum.random(pids)
           x = length(rand)
           if(rand == pid || Enum.member?(neigh, rand)) do
                
                chooseRandom(neigh, pid,pids)
           
            else
                
                 x = length(rand)
                 
                 a = Enum.at(rand,x-1)
                 
                 a
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
        count = 0;
        Enum.each 0..root-1, fn i ->
            Enum.each 0..root-1, fn j ->
                count = count + 1
                IO.inspect(count)
                neigh = []
                me = Enum.at(Enum.at(pids,i),j)
                IO.inspect(me)
                if (i==0 && j == 0) do
                    IO.puts("hi")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                   
                    neigh = [pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    IO.inspect(neigh)
                    send(me,{neigh, me})
                else if (i==0 && j == root-1) do
                IO.puts("hi1")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    IO.inspect(neigh)
                    send(me,{neigh, me})
                else if (i == root-1 && j == root-1) do
                IO.puts("hi2")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    IO.inspect(neigh)
                    send(me,{neigh, me})
                else if (i == root-1 && j == 0) do
                IO.puts("hi3")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    IO.inspect(neigh)
                    send(me,{neigh, me})
                else if (j==0) do
                IO.puts("hi4")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    IO.inspect(neigh)
                    send(me,{neigh, me})
                else if (i==0) do
                IO.puts("hi5")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me})
                else if (i==root-1) do
                IO.puts("hi6")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me})
                else if (j==root-1) do
                IO.puts("hi7")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me})
                else
                IO.puts("hi8")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(me,{neigh, me}) 
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
    IO.puts("exit")
    end

    def createGrid(num) do
   neighbor=[]
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
        IO.inspect (num)
        IO.inspect (root)
        count = 0;
        pids = Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0) 
                Enum.map(1..root, fn(x) ->spawn(&Topologies.rep/0)end)end)
        
        Enum.each 0..root-1, fn i ->
            Enum.each 0..root-1, fn j ->
                neigh = []
                count = count + 1
                IO.inspect (count)
                me = Enum.at(Enum.at(pids,i),j)
                IO.inspect (me)
                if (i==0 && j == 0) do
                    IO.puts("hi")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0 && j == root-1) do
                IO.puts("hi1")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == root-1) do
                IO.puts("hi2")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i == root-1 && j == 0) do
                IO.puts("hi3")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==0) do
                IO.puts("hi4")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==0) do
                IO.puts("hi5")
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (i==root-1) do
                IO.puts("hi6")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else if (j==root-1) do
                IO.puts("hi7")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid]
                    send(Enum.at(Enum.at(pids,i),j),{neigh, me})
                else
                IO.puts("hi8")
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2]
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
     IO.puts("I have exited the loop")
    end

    def createFull(num) do
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        
    end
end