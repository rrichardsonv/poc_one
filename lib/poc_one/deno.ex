defmodule PocOne.Deno do
  use Rustler,
    otp_app: :poc_one,
    crate: :deyas

  # When loading a NIF module, dummy clauses for all NIF function are required.
  # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.
  def js(_arg1), do: :erlang.nif_error(:nif_not_loaded)
end
