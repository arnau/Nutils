PROJECT_PATH = File.dirname(__FILE__)
LIB_PATH = File.join PROJECT_PATH , 'lib'

$:.unshift LIB_PATH


# load project tasks
Dir['tasks/**/*.rake'].each { |rakefile| load rakefile }
