defmodule NicoWeb.Nico do
  use NicoWeb, :html

  def video(assigns) do
    ~H"""
      <div class="flex pt-2">
        <div>
          <a href={"https://nico.ms/#{get(@video, :content_id)}"} target="_blank" class="video-image-wrapper">
            <img src={get(@video, :thumbnail_url)} style="min-width: 130px" />
            <span class="video-length">
              <%= NicoWeb.ViewHelpers.Nico.convert_length_seconds(get(@video, :length_seconds)) %>
            </span>
          </a>
        </div>
        <div class="pl-1">
          <div>
            <a href={"https://nico.ms/#{get(@video, :content_id)}"} target="_blank">
              <%= get(@video, :title) %>
            </a>
          </div>
          <div>
            投稿日: <%= NicoWeb.ViewHelpers.Nico.convert_datetime(get(@video, :start_time)) %>
          </div>
          <div>
            <span>
              <i class="fa-regular fa-eye"></i>
              <%= get(@video, :view_counter) %>
            </span>
            <span>
              <i class="fa-regular fa-heart"></i>
              <%= get(@video, :mylist_counter) %>
            </span>
            <span>
              <i class="fa-regular fa-thumbs-up"></i>
              <%= get(@video, :like_counter) %>
            </span>
            <span>
              <i class="fa-regular fa-comment"></i>
              <%= get(@video, :comment_counter) %>
            </span>
          </div>
        </div>
      </div>
    """
  end

  defp get(map, atom) do
    Map.get(map, atom) || Map.get(map, to_string(atom))
  end

  def header_nav(assigns) do
    ~H"""
      <nav>
        <ul class="flex">
          <li class="px-2 border rounded-md"><.link href={~p"/nico/search"}>search</.link></li>
          <li class="px-2 border rounded-md"><.link href={~p"/nico/bulk"}>bulk</.link></li>
        </ul>
      </nav>
    """
  end
end
