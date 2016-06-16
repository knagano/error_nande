# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'error_nande/version'

Gem::Specification.new do |spec|
  spec.name          = "error_nande"
  spec.version       = ErrorNande::VERSION
  spec.authors       = ["Keiichiro Nagano"]
  spec.email         = ["knagano@CPAN.org"]

  spec.summary       = %q{アイエエエエ! エラー!? エラーナンデ!?}
  spec.description   = %q{例外を整形して文字列1行で返す}
  spec.homepage      = %q{https://github.com/knagano/error_nande}

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  #spec.add_development_dependency "rails" # NOTE: uncomment to run spec

end
