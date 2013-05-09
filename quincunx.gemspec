Gem::Specification.new do |s|
  s.name          = 'quincunx'
  s.version       = '0.0.1'
  s.date          = '2013-04-22'
  s.summary       = "Pattern matching for method dispatch - in Ruby?!"
  s.description   = "This probably shouldn't work..."
  s.authors       = ["Russell Dunphy"]
  s.email         = ['russell@russelldunphy.com']
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage      = 'http://github.com/rsslldnphy/quincunx'

  s.add_dependency "optional"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"

end

