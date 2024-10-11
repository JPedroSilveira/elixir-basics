defmodule Lottery.Util.StringUtil do
  @chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

  def generate(length \\ 255) do
    length
    |> do_randomizer()
  end

  defp get_range(length) when length > 1, do: (1..length)
  defp get_range(_length), do: [1]

  defp do_randomizer(length) do
    chars_list = String.split(@chars, "", trim: true)
    get_range(length)
    |> Enum.reduce([], fn(_, acc) -> [Enum.random(chars_list) | acc] end)
    |> Enum.join("")
  end
end
