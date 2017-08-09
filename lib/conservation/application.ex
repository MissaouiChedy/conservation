defmodule Conservation.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Conservation.ProcSupervisor, []},
    ]

    opts = [strategy: :one_for_one, name: Conservation.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
