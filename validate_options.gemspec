Gem::Specification.new do |s|
  s.name = 'validate_options'
  s.version = '0.0.1'
  s.summary = %{Hash validation for 'options'-like methods.}
  s.description = %{}
  s.date = %q{2008-09-19}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/validate_options.rb", "README"]

  s.require_paths = ["lib"]

  s.extra_rdoc_files = ["README"]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "tti", "--main", "README"]
end
