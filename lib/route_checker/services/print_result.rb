# frozen_string_literal: true

module RouteChecker
  module Services
    class PrintResult
      class << self
        MAX_MESSAGE_TITLE_WIDTH = 150
        
        def call(data)
          print_uninitialized_controllers(data)
          print_unreachable_actions(data)
          print_unused_routes(data)
        end

        private

        def print_uninitialized_controllers(data)
          return puts " 0 UNINITIALIZED CONTROLLER'S FOUND. \n" if data[:uninitilzed_contant].empty?

          puts "\n\n"
          puts " #{data[:uninitilzed_contant].count} UNINITIALIZED CONTROLLER'S: ROUTE IS PRESENT BUT IT'S CONTROLLER IS MISSING ".center(MAX_MESSAGE_TITLE_WIDTH, "=>")
          data[:uninitilzed_contant].each do |data|
            puts "#{data[:verb]} #{data[:route]}, #{"Controller:"} #{data[:controller]} "
          end
          puts " END ".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end

        def print_unreachable_actions(data)
          return puts " 0 UNREACHABLE ACTIONS FOUND. \n" if data[:unreachable_actions].empty?
          procs = []
          counter = 0
          puts "\n\n"
          p = Proc.new{|count| puts " #{count} UNREACHABLE ACTIONS: ACTION IS PRESENT IN CONTROLLER BUT IT'S ROUTE IS MISSING ".center(MAX_MESSAGE_TITLE_WIDTH, "=>") } 
          data[:unreachable_actions].each do |key, values|
            values.each do |val|
              counter = counter + 1
              procs.push(Proc.new { puts "#{"Controller:"} #{key}, #{"Action:"} #{val}, #{"Source_Location:"} #{key.constantize.new.method(val).source_location}" })
            end
          end
          p.call(counter)
          procs.each{|p| p.call }
          puts " END ".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end

        def print_unused_routes(data)
          return puts " 0 UNUSED ROUTES FOUND. \n" if data[:unused_actions].try(:empty?)
          puts "\n\n"
          puts " #{data[:unused_actions].count} UNUSED ROUTES: ROUTE IS PRESENT BUT IT'S CONTROLLER'S ACTION IS MISSING ".center(MAX_MESSAGE_TITLE_WIDTH, "=>")
          data[:unused_actions].each do |values|
            puts "#{values[3]} #{values[2]}, #{"Controller:"} #{values[0]}, #{"Action:"} #{values[1]}"
          end
          puts " END ".center(MAX_MESSAGE_TITLE_WIDTH, "<=")
        end
      end
    end
  end
end
