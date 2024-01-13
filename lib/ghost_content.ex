defmodule GhostContent do
  @moduledoc """
  An Elixir client for the Ghost publishing platform's Content API.

  Full documentation of the Ghost Content API is available at:
  https://ghost.org/docs/content-api/
  """

  @type config() :: [api_key: String.t(), host: String.t()]
  @type options() :: [
          filter: String.t() | nil,
          include: String.t() | nil,
          page: String.t() | nil,
          limit: String.t() | nil,
          order: String.t() | nil,
          fields: String.t() | nil
        ]
  @type meta() :: %{
          next: String.t() | nil,
          prev: String.t() | nil,
          total: integer(),
          limit: integer(),
          pages: integer(),
          page: integer()
        }

  alias GhostContent.{Author, Post, Tag}

  @doc """
  Loads a configuration for use in subsequent API calls.
  """
  @spec config(atom()) :: config()
  def config(otp_app) do
    Application.get_env(otp_app, :ghost_content)
  end

  @doc """
  Gets a list of posts.

  Accepts the following options:
  `limit, page, filter, order, fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#posts
  """
  @spec get_posts(config(), options() | nil) :: {:ok, %{meta: meta(), posts: [Post.t()]}}
  def get_posts(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single post by ID.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#posts
  """
  @spec get_post(config(), String.t(), options() | nil) :: {:ok, %{posts: [Post.t()]}}
  def get_post(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/#{id}/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single post by Slug.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#posts
  """
  @spec get_post_by_slug(config(), String.t(), options() | nil) :: {:ok, %{posts: [Post.t()]}}
  def get_post_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/slug/#{slug}/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a list of pages.

  Accepts the following options:
  `limit, page, filter, order, fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#pages
  """
  @spec get_pages(config(), options() | nil) :: {:ok, %{pages: [Post.t()]}}
  def get_pages(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single page by ID.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#pages
  """
  @spec get_page(config(), String.t(), options() | nil) :: {:ok, %{pages: [Post.t()]}}
  def get_page(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/#{id}/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single page by Slug.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#pages
  """
  @spec get_page_by_slug(config(), String.t(), options() | nil) :: {:ok, %{pages: [Post.t()]}}
  def get_page_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/slug/#{slug}/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a list of authors.

  Accepts the following options:
  `limit, page, filter, order, fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#authors
  """
  @spec get_authors(config(), options() | nil) :: {:ok, %{authors: [Author.t()]}}
  def get_authors(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single author by ID.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#authors
  """
  @spec get_author(config(), String.t(), options() | nil) :: {:ok, %{authors: [Author.t()]}}
  def get_author(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/#{id}/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single author by Slug.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#authors
  """
  @spec get_author_by_slug(config(), String.t(), options() | nil) ::
          {:ok, %{authors: [Author.t()]}}
  def get_author_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/slug/#{slug}/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a list of tags.

  Accepts the following options:
  `limit, page, filter, order, fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#tags
  """
  @spec get_tags(config(), options() | nil) :: {:ok, %{tags: [Tag.t()]}}
  def get_tags(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/tags/", opts) do
      {:ok, r = %{tags: tags}} ->
        {:ok, %{r | tags: Enum.map(tags, &Tag.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single tag by ID.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#tags
  """
  @spec get_tag(config(), String.t(), options() | nil) :: {:ok, %{tags: [Tag.t()]}}
  def get_tag(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/tags/#{id}/", opts) do
      {:ok, r = %{tags: tags}} ->
        {:ok, %{r | tags: Enum.map(tags, &Tag.from_map!/1)}}

      e ->
        e
    end
  end

  @doc """
  Gets a single tag by Slug.

  Accepts the following options:
  `fields, include`

  For exact usage, see: https://ghost.org/docs/content-api/#tags
  """
  @spec get_tag_by_slug(config(), String.t(), options() | nil) :: {:ok, %{tags: [Tag.t()]}}
  def get_tag_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/tags/slug/#{slug}/", opts) do
      {:ok, r = %{tags: tags}} ->
        {:ok, %{r | tags: Enum.map(tags, &Tag.from_map!/1)}}

      e ->
        e
    end
  end

  defp perform_request(config, path, opts) do
    params =
      %{
        limit: Keyword.get(opts, :limit, 15),
        page: Keyword.get(opts, :page, 1),
        filter: Keyword.get(opts, :filter, nil),
        order: Keyword.get(opts, :order, nil),
        fields: Keyword.get(opts, :fields, nil),
        include: Keyword.get(opts, :include, nil)
      }
      |> Enum.reduce(%{}, fn
        {_, nil}, a -> a
        {k, v}, a -> Map.put(a, k, v)
      end)

    uri_string =
      "#{config[:host]}#{path}"
      |> URI.parse()
      |> Map.put(:query, URI.encode_query(Map.merge(params, %{key: config[:api_key]})))
      |> URI.to_string()

    with {:ok, response = %HTTPoison.Response{status_code: 200}} <-
           HTTPoison.get(uri_string),
         {:ok, data} <- Jason.decode(response.body, keys: :atoms) do
      {:ok, data}
    else
      {_, result} -> {:error, result}
    end
  end
end
