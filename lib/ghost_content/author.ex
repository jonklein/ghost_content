defmodule GhostContent.Author do
  @moduledoc """
  A ghost Author - https://ghost.org/docs/content-api/#authors
  """

  # todo
  @type t() :: %__MODULE__{}

  defstruct slug: "",
            id: "",
            name: nil,
            cover_image: nil,
            profile_image: nil,
            meta_title: nil,
            meta_description: nil,
            bio: nil,
            website: nil,
            url: nil,
            location: nil,
            facebook: nil,
            twitter: nil,
            count: %{}

  @spec from_map!(map()) :: t()
  def from_map!(m) do
    Kernel.struct!(__MODULE__, m)
  end
end
