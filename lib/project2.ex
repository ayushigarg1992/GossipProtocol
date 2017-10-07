defmodule Project2 do
  @moduledoc """
  Documentation for Project2.
  """

  @doc """
  Hello world.
  ## Examples
      iex> Project2.hello
      :world
  """
  def main(args) do
    start_up(args)
  end
  
  def start_up(args) do
    {num,_} = Integer.parse(Enum.at(args,0))
    algo = Enum.at(args,2)
    topo = Enum.at(args,1)

    MyRegistry.start_link
    Manager.start_link
    {:ok,pid_tracker} = Tracker.start_link  
    #num = Integer.parse(num)
    cond do
      
     topo== "line" ->
      Topologies.createLine(num,algo,pid_tracker)
    topo == "2D" -> 
      Topologies.createGrid(num,algo,pid_tracker)
    topo == "full" ->
      Topologies.createFull(num,algo,pid_tracker)
    topo == "imp2D"
      Topologies.createImpGrid(num,algo,pid_tracker)
    
    end
  end
end