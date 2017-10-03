defmodule Topologies do
    


    def createLine(num) do
        pids = Enum.map(1..num, fn(x) ->Chat.Supervisor.start_node(x)end )
        list=Enum.each(pids, fn(x)->IO.inspect(x)end)
    end

    def createGrid(num) do
        root = :math.sqrt(num)
        if root*root<num do
            root = root+1

        end
    end

    def createImpGrid(num) do
        
    end

    def createFull(num) do
        
    end
end