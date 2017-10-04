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
  def start_up(num,topo,algo) do
    MyRegistry.start_link
    Manager.start_link
    Server.start_link("first node")
    cond do
      
     topo== "line" ->
      Topologies.createLine(num)
    topo == "grid" -> 
      Topologies.createGrid(num)
    topo == "full" ->
      Topologies.createFull(num)
    topo == "impgrid"
      Topologies.createImpGrid(num)
    
    end
  end
end
