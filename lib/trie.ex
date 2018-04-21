defmodule Trie do

  defstruct [
    children: %{},
    value: nil
  ]

  # ==========================================================================
  # Basic operations
  # ==========================================================================

  def new(value \\ nil) do
    %__MODULE__{value: value}
  end

  def get(%__MODULE__{children: children}, char, default \\ nil) do
    Map.get(children, char, default)
  end

  def put(cur = %__MODULE__{children: children}, char, child = %__MODULE__{}) do
    %{cur | children: Map.put(children, char, child)}
  end

  # ==========================================================================
  # Secondary operations
  # ==========================================================================

  def insert(trie, string, value) when is_binary(string) do
    insert(trie, String.to_charlist(string), value)
  end

  def insert(trie = %__MODULE__{}, [], value) do
    %__MODULE__{trie | value: value}
  end

  def insert(trie = %__MODULE__{}, [char | rest], value) do
    child = get(trie, char, new())
    updated_child = insert(child, rest, value)

    put(trie, char, updated_child)
  end

  def lookup_value(trie, string) do
    case lookup(trie, string) do
      nil -> nil
      %__MODULE__{value: value} -> value
    end
  end

  def lookup(trie = %__MODULE__{}, string) when is_binary(string) do
    lookup(trie, String.to_charlist(string))
  end

  def lookup(trie = %__MODULE__{}, []) do
    trie
  end

  def lookup(trie = %__MODULE__{}, [char | rest]) do
    case get(trie, char) do
      nil ->
        new()
      child = %__MODULE__{} ->
        lookup(child, rest)
    end
  end

  def all_values(trie = %__MODULE__{}) do
    do_all_values(trie)
    |> List.flatten()
    |> Enum.map(fn {e} -> e end)
  end

  defp do_all_values(%__MODULE__{value: value, children: children}) do
    my_values = if value == nil, do: [], else: [{value}]

    other_values =
      children
      |> Map.values()
      |> Enum.map(&do_all_values/1)

    my_values ++ other_values
  end
end
