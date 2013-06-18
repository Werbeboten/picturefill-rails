# Used to ensure that Rails 3.0.x, as well as Rails >= 3.1 with asset pipeline disabled
# get the minified version of the scripts included into the layout in production.
module Picturefill
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        if config.action_view.javascript_expansions
          defaults = ::Rails.env.production? || ::Rails.env.test? ? %w(picturefill.min) : %w(picturefill)

          config.action_view.javascript_expansions[:defaults] |= defaults
        end
      end
    end
  end
end
