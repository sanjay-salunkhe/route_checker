# frozen_string_literal: true

module RouteChecker
  class Result
    class << self
      def uninitialized_controllers
        Services::UninitializedControllers.call
      end

      def unreachable_actions
        Services::UnreachableActions.call
      end

      def unused_routes
        Services::UnusedRoutes.call
      end

      def print
        Services::PrintResult.call(
          uninitilzed_contant: Services::UninitializedControllers.call,
          unreachable_actions: Services::UnreachableActions.call,
          unused_actions: Services::UnusedRoutes.call
        )
      end

      def save_to(location, filename, mode='w+', options = {})
        Services::SaveResultToFile.call(location, filename, mode, options)
      end
    end
  end
end
