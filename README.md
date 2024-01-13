# GhostContent

An Elixir client for the Ghost publishing platform's Content API.

This package allows you to use Ghost as a headless CMS in your Elixir/Phoenix project.
  
Full documentation of the Ghost Content API is available at:
https://ghost.org/docs/content-api/

## Installation

The package can be installed by adding `ghost_content` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ghost_content, "~> 0.1.0"}
  ]
end
```

Full documentation can be found at <https://hexdocs.pm/ghost_content>.

## Configuration

You'll need to configure ghost_content with your Ghost Content API host and key, as follows:

```
config :my_app, :ghost_content,
  host: "https://my.ghost.host",
  api_key: "my-ghost-api-key
```

Consult the [Ghost Content API documentation](https://ghost.org/docs/content-api/) for more information on creating an API key.

## Ghost Content Data Model

`ghost_content` defines three structures which mirror the 
core resources in the Ghost Content API:

```
%GhostContent.Post{}
%GhostContent.Tag{}
%GhostContent.Author{}
```

Note that the Ghost Content API exposes both "posts" and "pages", but that these both use the same data model, `%GhostContent.Post{}`.

## Usage

Once configured, you can start making requests.  

All API requests take a `config`, which is created as follows:

```
config = GhostContent.config(:ghost_content)
```

### The API

Getting Posts:

```
GhostContent.get_posts(config)
GhostContent.get_post(config, post_id)
GhostContent.get_post_by_slug(config, slug_id)
```

Getting Pages:

```
GhostContent.get_pages(config)
GhostContent.get_page(config, page_id)
GhostContent.get_page_by_slug(config, slug_id)
```

Getting Authors:

```
GhostContent.get_authors(config)
GhostContent.get_author(config, author_id)
GhostContent.get_author_by_slug(config, slug_id)
```

Getting Tags:

```
GhostContent.get_tags(config)
GhostContent.get_tag(config, tag_id)
GhostContent.get_tag_by_slug(config, slug_id)
```

All API calls can be given options of `include` and `fields` to specify what exact data to return.  Here are some examples,
but consult the [Ghost Content API documentation](https://ghost.org/docs/content-api/) for accepted values for each 
resource type:

```
GhostContent.get_posts(config, include: "authors,tags")
GhostContent.get_pages(config, include: "authors,tags")
GhostContent.get_authors(config, include: "count.posts")
GhostContent.get_tags(config, include: "count.posts")

GhostContent.get_posts(config, fields: "title,url")
GhostContent.get_pages(config, fields: "title,url")
```

All of the calls which return multiple resources (`get_posts`, `get_pages`, `get_tags`, and `get_authors`) 
can take options of `order`, `page`, `filter` and `limit`.
Once again, consult the [official documentation](https://ghost.org/docs/content-api/) for exact details on using 
these options with the various resources.

```
GhostContent.get_posts(config, limit: "all")
GhostContent.get_pages(config, limit: "15", page: 2)
GhostContent.get_pages(config, filter: "tag:elixir)
GhostContent.get_pages(config, filter: "visibility:public)
```


### Response Format

The content API exposes two types of calls: those which return
a list of resources, and those which return a single resource.  They have a similar response format, except that calls returning a list include a `meta` map containing pagination data:

```
{:ok, %{meta: %{...}, posts: [...]}} = GhostContent.get_posts(config)

{:ok, %{posts: [...]}} = GhostContent.get_post(config, post_id)

# Meta-format:
%{
  pagination: %{total: 1, next: nil, prev: nil, limit: 15, pages: 1, page: 1}
}
```

Note that calls returning a single resource still provide the data in 
a list of length 1.

