# frozen_string_literal: true

require_relative "lib/binary_heap_data_structure/version"

Gem::Specification.new do |spec|
  spec.name = "binary_heap_data_structure"
  spec.version = BinaryHeapDataStructure::VERSION
  spec.authors = ["mokoaki"]
  spec.email = ["mokoriso@gmail.com"]

  spec.summary = "summary"
  spec.description = "description"
  spec.homepage = "https://github.com/mokoaki/binary_heap_data_structure"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*.rb", "*.gemspec", "LICENSE"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
