
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "komposer/version"

Gem::Specification.new do |spec|
  spec.name          = "komposer"
  spec.version       = Komposer::VERSION
  spec.authors       = ["Florent Ferry"]
  spec.email         = ["florent@ouvrages-web.fr"]

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
end
