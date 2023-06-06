require_relative "repro.bundle"

pid = Process.fork {}
puts "forked"
Process.wait pid
