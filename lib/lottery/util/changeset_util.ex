defmodule Lottery.Util.ChangesetUtil do
  def translate_errors({msg, info}) do
    Regex.replace(
      ~r"%{(\w+)}", msg, fn _, key ->
        info |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end
    )
  end
end
