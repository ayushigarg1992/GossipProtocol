defmodule Manager do
    use Supervisor
    def start_link do
         Supervisor.start_link(__MODULE__, [], name: :gossip_supervisor)
      end
      def start_node(selfNode,neigh,next_neighbor,id) do

       Supervisor.start_child(:gossip_supervisor, [selfNode,neigh,next_neighbor,id])
        
      end
      def init(_) do
        children = [
          worker(Server, [])
        ]
        
        supervise(children, strategy: :simple_one_for_one)
      end
  end