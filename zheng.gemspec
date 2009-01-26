Gem::Specification.new do |s|
  s.name = 'zheng'
  s.version = '0.0.3'
  s.summary = %{A go ratings calculator, based on the method published by the European Go Federation}
  s.date = %q{2009-01-26}
  s.author = "Nacho Facello"
  s.email = "nacho@nucleartesuji.com"
 
  s.specification_version = 2 if s.respond_to? :specification_version=
 
  s.files = ["lib/zheng/actions/database.rb",
             "lib/zheng/actions/game.rb",
             "lib/zheng/actions/player.rb",
             "lib/zheng/actions.rb",
             "lib/zheng/game.rb",
             "lib/zheng/parameters.rb",
             "lib/zheng/player.rb",
             "lib/zheng/rating.rb",
             "lib/zheng/util.rb",
             "config/init.rb",
             "lib/zheng.rb",
             "config/default.yaml",
             "README.rdoc",
             "LICENSE"]
 
  s.require_paths = ['lib']
 
  s.bindir = "bin"
  s.executables = "zheng"
 
  s.add_dependency("sequel", ">= 2.8.0")
 
  s.has_rdoc = false

end
