defmodule PocOneWeb.PageView do
  use PocOneWeb, :view
  alias PocOne.Deno

  def render_comp(comp_name, assigns) do
    component =
      comp_name
      |> janky_read_file()
      |> wrap_execution(assigns)
      |> Deno.js()
      |> Phoenix.HTML.raw()

    ~E"""
    <template shadowroot="open">
      <%= component %>
    </template>
    """
  end

  def janky_read_file(comp_name) do
    # Would eventually precompiling these to avoid io
    :poc_one
    |> Application.app_dir("../../../../assets/js/#{comp_name}.js")
    |> File.read!()
    |> replace(~r/export( default)?/, "")
  end

  def wrap_execution(code, assigns) do
    props =
      assigns
      |> Map.drop([:conn])
      |> Enum.map(fn {k, v} ->
        {k
        |> Atom.to_string()
        |> Phoenix.Naming.camelize()
        |> replace(~r/^[A-Z]/, &String.downcase/1), v}
      end)
      |> Enum.into(%{})
      |> Jason.encode!()

    """
    class HTMLElement {
      constructor () {
        this.parentNode = this;
      }

      attachShadow () {
        return {};
      }
    }
    #{code}
    Object.assign(WordCount.prototype, #{props});
    const el = new WordCount();
    el.render();
    """
  end


  def replace(str, regex, repl) do
    Regex.replace(regex, str, repl)
  end
end
