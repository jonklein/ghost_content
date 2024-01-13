defmodule GhostContent do
  alias GhostContent.{Author, Post, Tag}

  def config(otp_app) do
    Application.get_env(otp_app, :ghost_content)
  end

  def get_posts(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_post(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/#{id}/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_post_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/posts/slug/#{slug}/", opts) do
      {:ok, r = %{posts: posts}} ->
        {:ok, %{r | posts: Enum.map(posts, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_pages(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_page(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/#{id}/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_page_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/pages/slug/#{slug}/", opts) do
      {:ok, r = %{pages: pages}} ->
        {:ok, %{r | pages: Enum.map(pages, &Post.from_map!/1)}}

      e ->
        e
    end
  end

  def get_authors(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  def get_author(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/#{id}/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  def get_author_by_slug(config, slug, opts \\ []) do
    case perform_request(config, "/ghost/api/content/authors/slug/#{slug}/", opts) do
      {:ok, r = %{authors: authors}} ->
        {:ok, %{r | authors: Enum.map(authors, &Author.from_map!/1)}}

      e ->
        e
    end
  end

  def get_tags(config, opts \\ []) do
    case perform_request(config, "/ghost/api/content/tags/", opts) do
      {:ok, r = %{tags: tags}} ->
        {:ok, %{r | tags: Enum.map(tags, &Tag.from_map!/1)}}

      e ->
        e
    end
  end

  def get_tag(config, id, opts \\ []) do
    case perform_request(config, "/ghost/api/content/tags/#{id}/", opts) do
      {:ok, r = %{tags: tags}} ->
        {:ok, %{r | tags: Enum.map(tags, &Tag.from_map!/1)}}

      e ->
        e
    end
  end

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
