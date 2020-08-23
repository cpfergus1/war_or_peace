Dir["./lib/*.rb"].each {|file| require file}


start = Start.new
start.welcome
