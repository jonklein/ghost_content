defmodule GhostContent.Post do
  @moduledoc """
  A ghost Post or Page https://ghost.org/docs/content-api/#posts
  """

  # todo
  @type t() :: %__MODULE__{}

  alias GhostContent.{Author, Tag}

  defstruct slug: "",
            id: "",
            uuid: "",
            title: "",
            html: "",
            access: nil,
            feature_image: "",
            feature_image_alt: "",
            feature_image_caption: "",
            featured: false,
            show_title_and_feature_image: false,
            meta_title: nil,
            meta_description: nil,
            created_at: nil,
            updated_at: nil,
            published_at: nil,
            custom_excerpt: "",
            comment_id: nil,
            comments: false,
            codeinjection_head: nil,
            codeinjection_foot: nil,
            og_image: nil,
            og_title: nil,
            og_description: nil,
            twitter_image: nil,
            twitter_title: nil,
            twitter_description: nil,
            custom_template: nil,
            canonical_url: nil,
            authors: [],
            tags: [],
            frontmatter: nil,
            email_subject: nil,
            reading_time: nil,
            primary_author: nil,
            primary_tag: nil,
            url: "",
            visibility: nil,
            excerpt: ""

  @spec from_map!(map()) :: t()
  def from_map!(m) do
    Kernel.struct!(__MODULE__, m)
    |> put_in([Access.key(:created_at)], parse_date(m[:created_at]))
    |> put_in([Access.key(:updated_at)], parse_date(m[:updated_at]))
    |> put_in([Access.key(:published_at)], parse_date(m[:published_at]))
    |> put_in([Access.key(:tags)], parse_tags(m[:tags]))
    |> put_in([Access.key(:authors)], parse_authors(m[:authors]))
  end

  defp parse_tags(nil) do
    nil
  end

  defp parse_tags(t) do
    Enum.map(t, &Tag.from_map!/1)
  end

  defp parse_authors(nil) do
    nil
  end

  defp parse_authors(t) do
    Enum.map(t, &Author.from_map!/1)
  end

  defp parse_date(nil) do
    nil
  end

  defp parse_date(str) do
    {:ok, date, _} = DateTime.from_iso8601(str)
    date
  end
end
