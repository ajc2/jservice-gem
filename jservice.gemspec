# frozen_string_literal: true

require_relative "lib/jservice/version"

Gem::Specification.new do |spec|
  spec.name = "jservice"
  spec.version = Jservice::VERSION
  spec.authors = ["Alex Craik"]
  spec.email = ["contact@ajc2.xyz"]
  spec.license = "BSD-3-Clause"

  spec.summary = "Bindings to the jService REST API for Jeopardy questions."
  #spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/ajc2/jservice-gem"
  spec.required_ruby_version = ">= 2.6.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ajc2/jservice-gem"
  spec.metadata["changelog_uri"] = "https://github.com/ajc2/jservice-gem"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
