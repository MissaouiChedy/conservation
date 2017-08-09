defmodule Conservation.Server do
  @moduledoc """
    A GenServer that provides a function to increment integers
    while keeping track of the number of executed operations.

    This GenServer uses a companion state container GenServer 
    in which it stores its state in and recovers it from.

    The state of this Genserver looks like this:
    {n, state_container_pid}
      where:
            - n is the increment operations count
            - state_container_pid is the pid of the GenServer 
              acting as a state container
  """
  use GenServer
  alias Conservation.StateContainer

  def start_link state_container_pid do
    GenServer.start_link(__MODULE__, {{:initial}, state_container_pid}, name: :server)
  end
  
  @doc """
    Tries to recover the state of the GenServer if previously stored,
    otherwise it initializes with the default state.
  """
  def init({_, state_container_pid}) do
    case StateContainer.get(state_container_pid) do
      [] -> {:ok, {0, state_container_pid}}
      n when is_integer(n) -> {:ok, {n, state_container_pid}}
    end
  end
  
  @doc """
    Returns n + 1, while making sure to maintain the number of
    increment operations executed.
  """
  def increment pid, n do
    GenServer.call(pid, {:plus_one, n})
  end
  
  @doc """
    Causes the GenServer to crash with division by 0.
  """
  def die pid do
    GenServer.call(pid, :die)
  end
  
  def handle_call({:plus_one, m}, _from, {n, state_container_pid}) do
    {:reply, m + 1, {n + 1, state_container_pid}}
  end
  
  def handle_call(:die, _from, state) do
    {:reply, 1 / 0, state}
  end
  
  @doc """
    Makes sure that the state is saved before effectively
    terminating the GenServer.
  """
  def terminate _reason, state = {n, state_container_pid} do
    Conservation.StateContainer.set(state_container_pid, n)
    {:shutdown, state}      
  end

end
