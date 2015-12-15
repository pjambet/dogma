use Dogma.RuleBuilder

defrule Dogma.Rule.HardTabs do
  @moduledoc ~S"""
  Requires that all indentation is done using spaces rather than hard tabs.

  So the following would be invalid:

      def something do
      \t:body # this line starts with a tab, not spaces
      end
  """

  def test(_rule, script) do
    script.lines
    |> Enum.filter(&tabs_at_start?/1)
    |> Enum.map(&error/1)
  end


  defp tabs_at_start?({_, line}) do
    String.starts_with?(line, "\t")
  end

  defp error({pos, _}) do
    %Error{
      rule:    __MODULE__,
      message: "Hard tab indention. Use spaces instead.",
      line:    Dogma.Script.line(pos),
    }
  end
end
