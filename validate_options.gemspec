Gem::Specification.new do |s|
  s.name = 'validate_options'
  s.version = '0.0.2'
  s.summary = %{Hash validation for 'options'-like methods.}
  s.description = %{}
  s.date = %q{2008-09-19}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/validate_options/spec.rb", "lib/validate_options.rb", "README.rdoc"]

  s.require_paths = ["lib", "lib/validate_options"]

  s.extra_rdoc_files = ["README.rdoc"]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "tti", "--main", "README.rdoc"]
end
