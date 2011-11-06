# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_orderable}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Maciej Mensfeld}]
  s.date = %q{2011-11-06}
  s.description = %q{Rails gem allowing ActiveRecord models to have order and to move them up and down}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{README.md}, %q{lib/acts_as_orderable.rb}]
  s.files = [%q{CHANGELOG.rdoc}, %q{Gemfile}, %q{MIT-LICENSE}, %q{Manifest}, %q{README.md}, %q{Rakefile}, %q{init.rb}, %q{lib/acts_as_orderable.rb}, %q{spec/acts_as_orderable_spec.rb}, %q{spec/spec_helper.rb}, %q{acts_as_orderable.gemspec}]
  s.homepage = %q{https://github.com/mensfeld/Acts-as-Orderable}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Acts_as_orderable}, %q{--main}, %q{README.md}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{acts_as_orderable}
  s.rubygems_version = %q{1.8.5}
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
