require 'rake'
require './lib/arguvia/version.rb'

Gem::Specification.new do |s|
  s.name        = 'arguvia'
  s.version     = Arguvia::VERSION
  s.summary     = "A function-like argument parser for command-line applications."
  s.description = "This script allows applications to parse and use command-line arguments in a "
                + "function-like fashion. For example, 'dict words(10) open-file(words.txt)'"
  s.authors     = ["Joseph"]
  s.email       = "fluorine@github.com"
  s.files       = FileList['lib/**/*.rb', 'bin/*', '*.md', '*.txt', 'test/**/*'].to_a
  s.homepage    = 'https://github.com/fluorine/Arguvia'
  s.license     = 'MIT'
end