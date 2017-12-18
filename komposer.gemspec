
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "komposer/version"

Gem::Specification.new do |spec|
  spec.name          = "komposer"
  spec.version       = Komposer::VERSION
  spec.authors       = ["Komposable"]
  spec.email         = ["contact@komposable.io"]

  spec.summary       = "" 
  spec.description   = ""
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "activerecord", ">= 4.0"
  spec.add_runtime_dependency "sass-rails"

  spec.add_runtime_dependency "bootstrap-sass"
  spec.add_runtime_dependency "bootstrap_form", '>= 2.3.0'

  spec.add_runtime_dependency "jquery-rails"
  spec.add_runtime_dependency "sortable-rails"
  spec.add_runtime_dependency "tinymce-rails"
  spec.add_runtime_dependency "tinymce-rails-langs"
end
