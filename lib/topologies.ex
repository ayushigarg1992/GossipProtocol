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
        neighbor=[]
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        num = root* root
        IO.puts(root)
        pids = Enum.map(1..root, fn(x) ->Manager.start_node(x) 
                Enum.map(1..root, fn(x) ->Manager.start_node(x)end)end)
                list=Enum.each(pids, fn(x)->IO.inspect(x)end)
        
        for i <- 0..root-1 do
            for j <- 0..root-1 do
                if (i==0 && j == 0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid1,pid|neighbor]
                else if (i==0 && j == root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid1,pid|neighbor]
                else if (i == root-1 && j == root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid1,pid|neighbor]
                else if (i == root-1 && j == 0) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid1,pid|neighbor]
                else if (j==0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i-1),j)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (i==0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (i==root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (j==root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    {_,pid2} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid0,pid1,pid,pid2|neighbor] 
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

    def createImpGrid(num) do
    neighbor = []
        root = :math.sqrt(num)
        root = Float.ceil(root)
        {root,_} = Integer.parse("#{root}")
        IO.puts(root)
        pids = Enum.map(1..root, fn(x) ->Manager.start_node(x) 
                Enum.map(1..root, fn(x) ->Manager.start_node(x)end)end)
                list=Enum.each(pids, fn(x)->IO.inspect(x)end)

                for i <- 0..root-1 do
            for j <- 0..root-1 do
                if (i==0 && j == 0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid1,pid|neighbor]
                else if (i==0 && j == root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid1,pid|neighbor]
                else if (i == root-1 && j == root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid1,pid|neighbor]
                else if (i == root-1 && j == 0) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid1,pid|neighbor]
                else if (j==0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i-1),j)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (i==0) do
                    {_,pid} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (i==root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i),j+1)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else if (j==root-1) do
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    neighbor = [pid0,pid1,pid|neighbor]
                else
                    {_,pid} = Enum.at(Enum.at(pids,i-1),j)
                    {_,pid1} = Enum.at(Enum.at(pids,i+1),j)
                    {_,pid0} = Enum.at(Enum.at(pids,i),j-1)
                    {_,pid2} = Enum.at(Enum.at(pids,i),j+1)
                    neighbor = [pid0,pid1,pid,pid2|neighbor] 
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