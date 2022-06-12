# frozen_string_literal: true

module RouteChecker
  module Services
    class UninitializedControllers
      class << self
        def call
          reload_routes
          uninitialized_controllers_list
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

        def uninitialized_controllers_list
          routes.each_with_object([]) do |route, uninitilzed_contant|
            next if route[0].nil?

            controller = begin
              "#{route[0].camelize}Controller".constantize
            rescue StandardError
              nil
            end
            uninitilzed_contant.push({controller:  "#{route[0].camelize}Controller", action: route[1], route: route[2], verb: route[3]}) unless controller.present?
          end
        end
      end
    end
  end
end
