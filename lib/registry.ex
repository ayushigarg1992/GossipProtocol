defmodule MyRegistry do
    use GenServer
    # API
    def start_link do
      
      GenServer.start_link(__MODULE__, nil, name: :registry)
    end
    def whereis_name(node_name) do
      GenServer.call(:registry, {:whereis_name, node_name})
    end
    def register_name(node_name, pid) do
      GenServer.call(:registry, {:register_name, node_name, pid})
    end
    def unregister_name(node_name) do
      GenServer.cast(:registry, {:unregister_name, node_name})
    end
    def send(node_name, message) do
      
      case whereis_name(node_name) do
        :undefined ->
          {:badarg, {node_name, message}}
        pid ->
          Kernel.send(pid, message)
          pid
      end
    end
    # SERVER
    def init(_) do
     
      {:ok, Map.new}
    end
    def handle_call({:whereis_name, node_name}, _from, state) do
      {:reply, Map.get(state, node_name, :undefined), state}
    end
    def handle_call({:register_name, node_name, pid}, _from, state) do
        case Map.get(state, node_name) do
          nil ->
            # When a new process is registered, we start monitoring it.
            Process.monitor(pid)
            {:reply, :yes, Map.put(state, node_name, pid)}
          _ ->
            {:reply, :no, state}
        end
      end
      def handle_info({:DOWN, _, :process, pid, _}, state) do
        
        {:noreply, remove_pid(state, pid)}
      end
      def remove_pid(state, pid_to_remove) do
        remove = fn {_key, pid} -> pid  != pid_to_remove end
        Enum.filter(state, remove) |> Enum.into(%{})
      end
    def handle_cast({:unregister_name, node_name}, state) do
      
      {:noreply, Map.delete(state, node_name)}
    end
  end