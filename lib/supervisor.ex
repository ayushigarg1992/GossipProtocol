defmodule Manager do
    use Supervisor
    def start_link do
         Supervisor.start_link(__MODULE__, [], name: :gossip_supervisor)
      end
      def start_node(name,neighbor,node,id) do
        Supervisor.start_child(:gossip_supervisor, [name,neighbor,node,id])
        
      end
      def init(_) do
        children = [
          worker(Server, [])
        ]
        
        supervise(children, strategy: :simple_one_for_one)
      end
  end