# frozen_string_literal: true

module RouteChecker
  module Services
    class UnusedRoutes
      class << self
        include  RouteChecker::Services::Reloader
        def call
          reload_routes
          routes.each_with_object([]) do |route, unused_routes|
            next if route[0].nil?

            controller = begin
              "#{route[0].camelize}Controller".constantize
            rescue StandardError
              next
            end

            unless controller.instance_methods.include?(route[1].to_sym)
              unused_routes.push(route)
            end
          end
        end

        private

        def reload_routes
          load File.join(Rails.root.to_s,'/config/routes.rb')
        end

        def routes
          ::Rails.application.routes.routes.map do |r|
            [r.defaults[:controller], r.defaults[:action], r.path.spec.to_s, r.verb.is_a?(String) ? r.verb : r.verb.source[/[a-z]+/i].to_s] unless r.defaults[:controller].nil?
          end.compact
        end
      end
    end
  end
end
