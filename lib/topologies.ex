defmodule Topologies do

    def createLine(num,neighbors) do
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        if n==0 do neighbors = [[1]|neighbors] end
        
                    if n>=1 && n<=num-1 do neighbors = [[n-1,n+1]|neighbors] end
        for n <- 0..num do
          
            {_,pid} = Enum.at(pids,n)
            
            if n==num do neighbors = [[num-1]|neighbors] end
            IO.inspect(Enum.at(neighbors,0))
        end
        
    end

    def createGrid(num) do
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        IO.puts(root)
        pids = Enum.map(1..root, fn(x) ->Manager.start_node(x) 
                Enum.map(1..root, fn(x) ->Manager.start_node(x)end)end)
                list=Enum.each(pids, fn(x)->IO.inspect(x)end)
  
    end

    def createImpGrid(num) do
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        IO.puts(root)
        pids = Enum.map(1..root, fn(x) ->Manager.start_node(x) 
                Enum.map(1..root, fn(x) ->Manager.start_node(x)end)end)
                list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        
    end

    def createFull(num) do
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        
    end
end