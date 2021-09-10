defmodule Tri.Guardian do
  use Guardian, otp_app: :tri

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = Tri.Account.get_user!(id)
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def get_claims(conn) do
    {:ok, claims} = Guardian.Plug.current_token(conn) |> decode_and_verify()

    claims
  end
end
