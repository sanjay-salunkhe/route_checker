# frozen_string_literal: true

module RouteChecker
  module Services
    class UnreachableActions
      class << self
        def call
          reload_routes
          require_controllers
          unreachable_actions(controllers_and_actions)
        end

        private

        def reload_routes
          load File.join(Rails.root.to_s,'/config/routes.rb')
        end

        def require_controllers
          Dir[Rails.root.join("app/controllers/**/*_controller.rb")].each { |file| require file }
        end

        def controllers_and_actions
          Rails.application.routes.routes.each_with_object(Hash.new { [] }) do |r, hash|

            next if r.defaults[:controller].nil?

            hash[r.defaults[:controller].camelize.to_s.concat("Controller")] =
              hash[r.defaults[:controller].camelize.to_s.concat("Controller")].concat([r.defaults[:action].to_sym])
          end
        end

        def unreachable_actions(all_controllers_and_actions)
          ApplicationController.descendants.each_with_object(Hash.new { [] }) do |controller, unreachable_actions_list|
            result = (controller.instance_methods(false) - all_controllers_and_actions[controller.to_s])
            unless result.empty?
              result.each do |action|
                unreachable_actions_list[controller.to_s] = unreachable_actions_list[controller.to_s].push(action) unless action.to_s.starts_with?("_")
              end
            end
          end
        end
      end
    end
  end
end