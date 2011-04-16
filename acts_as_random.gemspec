# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_random}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = %q{2011-04-17}
  s.description = %q{Rails gem allowing ActiveRecord models to have order and to move them up and down}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/acts_as_orderable.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "README.md", "Rakefile", "init.rb", "lib/acts_as_orderable.rb", "spec/acts_as_orderable_spec.rb", "spec/spec_helper.rb", "Manifest", "acts_as_random.gemspec"]
  s.homepage = %q{https://github.com/mensfeld/Acts-as-Orderable}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_random", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_random}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Rails gem allowing ActiveRecord models to have order and to move them up and down}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<active_record>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<active_record>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<active_record>, [">= 0"])
  end
end
