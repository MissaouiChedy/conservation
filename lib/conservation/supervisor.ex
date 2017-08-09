defmodule Conservation.ProcSupervisor do
  use Supervisor
  
  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: :supervisor)
  end

  def init(_arg) do
    Supervisor.init([{Conservation.StateContainer, []}, {Conservation.Server, :container}], strategy: :one_for_one)
  end

end
