module Picturefill
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        if config.action_view.javascript_expansions
          config.action_view.javascript_expansions[:defaults] |= ["picturefill.all"]
        end
      end
    end
  end
end
