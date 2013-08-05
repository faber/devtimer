require 'devtimer'

class DevTimer
  class CLI
    
    def initialize(argv, pid_file=nil)
      pid_file ||= File.expand_path('~/.devtimer.pid')
      @argv = argv
      @timer = DevTimer.new(pid_file)
    end
    
    def run
      case @argv.first
      when 'stop'
        @timer.stop
      when 'status', nil
        @timer.status
      when 'start'
        @timer.start(@argv[1])
      else
        raise "Unknown command #{@argv.first}"
      end
    end

  end
end