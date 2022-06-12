# frozen_string_literal: true

module RouteChecker
  module Services
    class SaveResultToFile
      class InvalidmodeError < StandardError; end

      class InvalidOptions < StandardError; end

      class << self
        MAX_MESSAGE_TITLE_WIDTH = 150

        def call(location, filename, mode, options={})
          File.open(File.join(location, filename), mode) do |f|
            unless valid_mode?(mode)
              f.close
              fail InvalidmodeError, "Invalid file mode specified. only 'a+' and 'w+' file modes are supported"
            end

            if options.empty?
              save_uninitialized_controllers(f)
              save_unreachable_actions(f)
              save_unused_routes(f)
            else
              unless valid_options?(options)
                f.close
                fail InvalidOptions, "Invalid options specified. expecting hash {:output_only => [<list of options>]}"
              end
              save_uninitialized_controllers(f) if options[:output_only].include?(:uninitialized_constants)
              save_unreachable_actions(f) if options[:output_only].include?(:unreachable_actions)
              save_unused_routes(f) if options[:output_only].include?(:unused_actions)
            end
            f.close
          end
        end

        private

        def valid_mode?(mode)
          ["a+", "w+"].include?(mode)
        end

        def valid_options?(options)
          options.key?(:output_only) && (options[:output_only] - [:uninitialized_constants, :unreachable_actions,
                                                                  :unused_actions]).empty?
        end

        def save_uninitialized_controllers(file)
          data = Services::UninitializedControllers.call
          return file.puts "0 UNINITIALIZED CONTROLLER'S FOUND.\n".green if data.empty?

          file.puts "\n\n"
          file.puts "#{data.count} UNINITIALIZED CONTROLLER'S: ROUTE IS PRESENT BUT IT'S CONTROLLER IS MISSING".center(MAX_MESSAGE_TITLE_WIDTH, "=>")
          Services::UninitializedControllers.call.each do |data|
            file.puts "#{data[:verb]} #{data[:route]}, #{"Controller:"} #{data[:controller]} "
          end
          file.puts "END".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end

        def save_unreachable_actions(file)
          data = Services::UnreachableActions.call
          return file.puts "0 UNREACHABLE ACTIONS FOUND.\n".green if data.empty?
          procs = []
          counter = 0

          file.puts "\n\n"
          p = Proc.new{|count| file.puts "#{count} UNREACHABLE ACTIONS: CONTROLLER'S ACTION IS PRESENT BUT IT'S ROUTE IS MISSING".center(MAX_MESSAGE_TITLE_WIDTH, "=>") } 
          data.each do |key, values|
            values.each do |val|
              counter = counter + 1
              procs.push(Proc.new { file.puts "#{"Controller:"} #{key}, #{"Action:"} #{val}, #{"Source_Location:"} #{key.constantize.new.method(val).source_location}" }) 
            end
          end
          p.call(counter)
          procs.each{|p| p.call }
          file.puts "END".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end

        def save_unused_routes(file)
          data = Services::UnusedRoutes.call
          return file.puts "0 UNUSED ROUTES FOUND.\n".green if data.empty?

          file.puts "\n\n"
          file.puts "#{data.count} UNUSED ROUTES: ROUTE IS PRESENT BUT IT'S CONTROLLER'S ACTION IS MISSING".center(MAX_MESSAGE_TITLE_WIDTH, "=>")
          data.each do |values|
            file.puts "#{values[3]} #{values[2]}, #{"Controller:"} #{values[0]}, #{"Action:"} #{values[1]}"
          end
          file.puts "END".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end
      end
    end
  end
end
