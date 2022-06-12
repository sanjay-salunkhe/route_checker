# frozen_string_literal: true

require_relative "lib/route_checker/version"

Gem::Specification.new do |spec|
  spec.name          = "route_checker"
  spec.version       = RouteChecker::VERSION
  spec.authors       = ["sanjay salunkhe"]
  spec.email         = ["sanjay.salunkhe@aylanetworks.com"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "route checker gem helps to find unused routes and unreachable actions in rails application."
  spec.homepage      = "https://github.com/sanjay-salunkhe/route_checker"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 1.9.3")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://testing.com"
  spec.metadata["changelog_uri"] = "http://testing.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "xyz", "x.x.x"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
