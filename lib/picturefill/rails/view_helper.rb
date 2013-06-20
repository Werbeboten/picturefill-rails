module Picturefill::Rails
  module ViewHelper

    # Usage: <%= picturefill(default_url, "AltText") do %>
    #          <%= image(small_url) %>
    #          <%= image(medium_url, :min => 400) %>
    #          <%= image(medium_high_dpi_url, :min => 400, :ratio => 1.5) %>
    #          <%= image(medium_high_dpi_url, :min => 400, :ratio => 1.5, :webkit => true) %>
    #          <%= image(large_url, :min => 1000) %>
    #          <%= image(large_high_dpi_url, "(min-width: 1000px) and (min-device-pixel-ratio: 1.5)") %>
    #        <%= end %>
    def picturefill(default_src, description, &block)
      raise ArgumentError.new("No Block given") unless block_given?

      images = Picturefill::Context.new(&block)

      content_tag :span, :data => { :alt => description, :picture => "" } do
        markup = content_tag(:span, "", :data => { :src => image_path(default_src) }).to_s

        images.each do |img|
          data = { :src => image_path(img.src) }
          data[:media] = img.media unless img.media.blank?

          markup << content_tag(:span, "", :data => data).to_s
        end

        markup << content_tag(:noscript, image_tag(default_src, :alt => description)).to_s

        markup
      end
    end

  end
end
