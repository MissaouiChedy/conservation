defmodule Conservation.Server do
  use GenServer
  alias Conservation.StateContainer

  def start_link state_container_pid do
    GenServer.start_link(__MODULE__, {{:initial}, state_container_pid}, name: :server)
  end
  
  def init({_, state_container_pid}) do
    case StateContainer.get(state_container_pid) do
      [] -> {:ok, {0, state_container_pid}}
      n when is_integer(n) -> {:ok, {n, state_container_pid}}
    end
  end
  
  def increment pid, n do
    GenServer.call(pid, {:plus_one, n})
  end
  
  def die pid do
    GenServer.call(pid, :die)
  end
  
  def handle_call({:plus_one, m}, _from, state = {n, state_container_pid}) do
    {:reply, m + 1, {n + 1, state_container_pid}}
  end
  
  def handle_call(:die, _from, state) do
    {:reply, 1 / 0, state}
  end
  
  def terminate _reason, state = {n, state_container_pid} do
    Conservation.StateContainer.set(state_container_pid, n)
    {:shutdown, state}      
  end

end
