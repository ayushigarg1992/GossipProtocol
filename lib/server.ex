# in lib/chat/server.ex
defmodule Server do
  use GenServer
  # API
  def start_link(name) do
    
    GenServer.start_link(__MODULE__, {})
  end
  # SERVER
  def init(args) do
    args =  {0,0,1}
    {:ok, args}
  end
  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end
  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
 
  def add_message(room_name, message) do
    
    GenServer.cast(via_tuple(room_name), {:add_message, message})
  end
  def get_messages(room_name) do
    GenServer.call(via_tuple(room_name), :get_messages)
  end
  defp via_tuple(room_name) do
    
    {:via, MyRegistry, {:chat_room, room_name}}
  end
end