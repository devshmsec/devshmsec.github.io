# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-gruvbox"
  spec.version       = "0.1.0"
  spec.authors       = ["Vinay Verma"]
  spec.email         = ["1mv1n4yv3rm4@gmail.com"]

  spec.summary       = "This theme is for jekyll pages insipired by gruvbox colorscheme."
  spec.homepage      = "https://github.com/devshmsec/devshmsec.github.io"
  spec.license       = "MIT"

  spec.metadata["plugin_type"]  = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.0"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.13.0"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.6.1"

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 12.0"
end
