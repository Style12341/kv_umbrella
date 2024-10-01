defmodule KV.Bucket do
  use Agent, restart: :temporary

  @doc """
  Starts a new bucket.
  """
  @spec start_link(list()) :: Agent.on_start()
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  @spec get(pid(), String.t() | atom()) :: term() | nil
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  @spec put(pid(), String.t() | atom(), term()) :: :ok
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  @doc """
  Deletes `key` from `bucket`.

  Returns the current value of `key`, if `key` exists.
  """
  @spec delete(pid(), String.t() | atom()) :: term() | nil
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
