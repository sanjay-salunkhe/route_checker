# frozen_string_literal: true

module RouteChecker
  module Services
    module Reloader
      private

      def reload_rails_console
        if Gem::Version.new(Rails.version) < Gem::Version.new("5.0.0.beta4")
          # ActionDispatch::Reloader.cleanup!
          # ActionDispatch::Reloader.prepare!
        else
        #  ::Rails.application.reloader.reload!
        end
      end
    end
  end
end
