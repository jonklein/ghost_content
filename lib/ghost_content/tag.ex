defmodule GhostContent.Tag do
  @moduledoc """
  A ghost Post or Page (both use the same structure)
  """

  defstruct slug: "",
            id: "",
            name: nil,
            description: nil,
            feature_image: nil,
            visibility: nil,
            url: nil,
            meta_title: nil,
            meta_description: nil,
            codeinjection_head: nil,
            codeinjection_foot: nil,
            og_image: nil,
            og_title: nil,
            og_description: nil,
            twitter_image: nil,
            twitter_title: nil,
            twitter_description: nil,
            canonical_url: nil,
            accent_color: nil,
            count: %{}

  @spec from_map!(map()) :: GhostContent.t()
  def from_map!(m) do
    Kernel.struct!(__MODULE__, m)
  end
end
