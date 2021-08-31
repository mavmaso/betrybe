defmodule Tri.UserFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def user_factory() do
        %Tri.Account.User{
          email: sequence(:email, &"test_#{&1}@example.com"),
          display_name: sequence(:display, &"Sr.N#{&1} Silva"),
          image: "http://images.com/exp.png",
          password: "somepassword"
        }
      end
    end
  end
end
