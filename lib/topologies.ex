defmodule Topologies do

    def createLine(num) do
        pids = Enum.map(1..num, fn(x) ->Manager.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        for n <- 0..num-1 do
          IO.puts(n)
         {_,pid} = Enum.at(pids,n)
          IO.inspect(pid)
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