defmodule Topologies do
    def rep do
       receive do {neigh}-> 
            Enum.each neigh, fn n->   
            Manager.start_node(n,neigh) 
            
        end 
    end
    end
    def createLine(num) do
        neighbors = []
        pids = Enum.map(1..num, fn(x) ->spawn(&Topologies.rep/0)end)
        Enum.each 0..num-1, fn id ->
            neigh = []
            if id==0 do
            neigh = [Enum.at(pids,id+1)|neigh]
            send(Enum.at(pids,id),neigh)
            else if id==num-1 do
            neigh = [Enum.at(pids,id-1)|neigh]
            send(Enum.at(pids,id),neigh)
            else
            neigh = [Enum.at(pids,id-1),Enum.at(pids,id+1)|neigh]
            send(Enum.at(pids,id),{neigh})
           
            end

            end
        end
            # if (x==0) do
            
                
            #     else if (x==num-1) do
                    
                    
                    
            #     else 
                
                
                
            #     end
            # end

        
        # for n <- 0..num-1 do
        #     if (n==0) do
        #         {_,pid} = Enum.at(pids,1)
        #         IO.puts "#{pid}"
        #         neighbors = [pid|neighbors]
                
        #     else if (n==num-1) do
        #         {_,pid} = Enum.at(pids,n-1)
        #         neighbors = [pid|neighbors]
        #         IO.puts "#{pid}"
                
                
        #     else 
        #         {_,pid1} = Enum.at(pids,n+1)
        #         {_,pid} = Enum.at(pids,n-1)
        #         neighbors = [pid,pid1|neighbors]
        #         IO.puts "#{pid}"
                
                
        #     end
        #     #to-do in the morning. Figure out message sending
        #     #Enum.each(list2,  fn neigh-> Server.send_rumor(neigh,n,"gossip")end)
        #     end


        #end
       # start_transmit(neighbors,pids,num)
       
        
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
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==0 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i == root-1 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i == root-1 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (j==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (j==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2|neigh]
                    rand = chooseRandom(neigh,Enum.at(Enum.at(pids,i),j),pids) 
                    neigh = [rand|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh}) 
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
                if (i==0 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==0 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i == root-1 && j == root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i == root-1 && j == 0) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (j==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i-1),j)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==0) do
                    pid = Enum.at(Enum.at(pids,i+1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (i==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i),j+1)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else if (j==root-1) do
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    neigh = [pid0,pid1,pid|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh})
                else
                    pid = Enum.at(Enum.at(pids,i-1),j)
                    pid1 = Enum.at(Enum.at(pids,i+1),j)
                    pid0 = Enum.at(Enum.at(pids,i),j-1)
                    pid2 = Enum.at(Enum.at(pids,i),j+1)
                    neigh = [pid0,pid1,pid,pid2|neigh]
                    send(Enum.at(Enum.at(pids,i),j),{neigh}) 
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