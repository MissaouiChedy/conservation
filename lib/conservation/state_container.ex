defmodule Conservation.StateContainer do
  @moduledoc """
    A GenServer that acts as a very simple single Erlang term store
    used in conjuncion with another GenServer.
  """
  use GenServer

  def start_link _ do
    GenServer.start_link(__MODULE__, [], name: :container)
  end

  @doc"""
    Returns the stored state
  """
  def get pid do
    GenServer.call(pid, :get)
  end
  
  @doc"""
    Updates the stored state
  """
  def set pid, new_state do
    GenServer.cast(pid, {:set, new_state})
  end
  
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set, new_state}, _state) do
    {:noreply, new_state}
  end
  
  def terminate _reason, _state do
    :shutdown    
  end
end
