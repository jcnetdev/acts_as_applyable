Gem::Specification.new do |s|
  s.name = 'acts_as_applyable'
  s.version = '0.3'
  s.date = '2008-09-18'
  
  s.summary = "A better (and safer) way of applying model attributes from your controller params"
  s.description = "Rid yourself of attr_accessible and attr_protected. This plugin allows you to stop using mass assignment, and gives you a more flexible way of interacting with your controller params."
  
  s.authors = ['RailsJedi']
  s.email = 'railsjedi@gmail.com'
  s.homepage = 'http://github.com/jcnetdev/acts_as_applyable'
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.add_dependency 'activerecord', ['>= 2.1']

  s.files = ["MIT-LICENSE",
            "README",
            "Rakefile",
            "acts_as_applyable.gemspec",
            "init.rb",
            "lib/acts_as_applyable.rb",
            "rails/init.rb"]

  s.test_files = ["test/acts_as_applyable_test.rb"]

end