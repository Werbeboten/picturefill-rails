module Picturefill
  module Rails
    class Engine < ::Rails::Engine

      initializer 'picturefill' do |app|
        ActiveSupport.on_load(:action_view) do
          require "picturefill/rails/view_helper"
          class ActionView::Base
            include Picturefill::Rails::ViewHelper
          end
        end
      end

    end
  end
end
