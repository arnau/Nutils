PROJECT_PATH = File.dirname(__FILE__)
LIB_PATH = File.join PROJECT_PATH , "lib"
SRC_PATH = File.join PROJECT_PATH , "src"

$:.unshift LIB_PATH


# load project tasks
Dir[LIB_PATH + "/tasks/**/*.rake"].each { |rakefile| load rakefile }
