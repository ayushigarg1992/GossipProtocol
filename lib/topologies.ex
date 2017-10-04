defmodule Topologies do

    def createLine(num) do
        neighbor = []
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        for n <- 0..num-1 do
            if (n==0) do
                {_,pid} = Enum.at(pids,1)
                neighbor = [pid|neighbor]
            
            else if (n==num-1) do
                {_,pid} = Enum.at(pids,n-1)
                neighbor = [pid|neighbor]
            
            else 
                {_,pid1} = Enum.at(pids,n+1)
                {_,pid} = Enum.at(pids,n-1)
                neighbor = [pid,pid1|neighbor]
            
            end
            end
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