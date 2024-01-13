defmodule GhostContentTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
    :ok
  end

  setup do
    ExVCR.Config.cassette_library_dir("./test/fixture/vcr_cassettes")
    %{client: GhostContent.config(:ghost_content)}
  end

  test "GhostContent.get_posts()", %{client: client} do
    use_cassette "get_posts" do
      assert {:ok, %{meta: %{}, posts: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_posts(client, filter: "tag:test")
    end
  end

  test "GhostContent.get_post()", %{client: client} do
    use_cassette "get_post" do
      assert {:ok, %{posts: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_post(client, "65a1f53da472cb0139ee1e88")
    end
  end

  test "GhostContent.get_post_by_slug()", %{client: client} do
    use_cassette "get_post_by_slug" do
      assert {:ok, %{posts: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_post_by_slug(client, "test-post")
    end
  end

  test "GhostContent.get_pages()", %{client: client} do
    use_cassette "get_pages" do
      assert {:ok, %{meta: %{}, pages: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_pages(client, filter: "tag:test")
    end
  end

  test "GhostContent.get_page()", %{client: client} do
    use_cassette "get_page" do
      assert {:ok, %{pages: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_page(client, "65a28057bda4e50139dece42")
    end
  end

  test "GhostContent.get_page_by_slug()", %{client: client} do
    use_cassette "get_page_by_slug" do
      assert {:ok, %{pages: [%GhostContent.Post{title: "Test"}]}} =
               GhostContent.get_page_by_slug(client, "test-page")
    end
  end

  test "GhostContent.get_authors()", %{client: client} do
    use_cassette "get_authors" do
      assert {:ok, %{meta: %{}, authors: [%GhostContent.Author{name: "SomeAuthor"}]}} =
               GhostContent.get_authors(client)
    end
  end

  test "GhostContent.get_author()", %{client: client} do
    use_cassette "get_author" do
      assert {:ok, %{authors: [%GhostContent.Author{name: "SomeAuthor"}]}} =
               GhostContent.get_author(client, "1")
    end
  end

  test "GhostContent.get_author_by_slug()", %{client: client} do
    use_cassette "get_author_by_slug" do
      assert {:ok, %{authors: [%GhostContent.Author{name: "SomeAuthor"}]}} =
               GhostContent.get_author_by_slug(client, "jon")
    end
  end

  test "GhostContent.get_tags()", %{client: client} do
    use_cassette "get_tags" do
      assert {:ok, %{meta: %{}, tags: [%GhostContent.Tag{name: "test"}]}} =
               GhostContent.get_tags(client)
    end
  end

  test "GhostContent.get_tag()", %{client: client} do
    use_cassette "get_tag" do
      assert {:ok, %{tags: [%GhostContent.Tag{name: "test"}]}} =
               GhostContent.get_tag(client, "65a1f5eea472cb0139ee1e90")
    end
  end

  test "GhostContent.get_tag_by_slug()", %{client: client} do
    use_cassette "get_tag_by_slug" do
      assert {:ok, %{tags: [%GhostContent.Tag{name: "test"}]}} =
               GhostContent.get_tag_by_slug(client, "test")
    end
  end
end
