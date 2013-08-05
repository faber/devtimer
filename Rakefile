PID_FILE = '/var/run/faber/devtimer.pid'

require './lib/devtimer'

$timer = DevTimer.new(PID_FILE)

task :default do

  
end

task :start, [:duration] do |t, args|
  $timer.start(args.duration || '15m')
end

task :status do
  puts $timer.running? ? "Timer running with pid #{$timer.pid}" : "Timer not running."
end

task :stop do
  $timer.stop
end