# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "acts_as_orderable"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = "2013-06-27"
  s.description = "Rails gem allowing ActiveRecord models to have order and to move them up and down"
  s.email = "maciej@mensfeld.pl"
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/acts_as_orderable.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "Manifest", "README.md", "Rakefile", "acts_as_orderable.gemspec", "init.rb", "lib/acts_as_orderable.rb", "spec/acts_as_orderable_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "https://github.com/mensfeld/Acts-as-Orderable"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_orderable", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "acts_as_orderable"
  s.rubygems_version = "2.0.0"
  s.summary = "Rails gem allowing ActiveRecord models to have order and to move them up and down"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<activerecord>, [">= 4.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<activerecord>, [">= 4.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<activerecord>, [">= 4.0.0"])
  end
end
