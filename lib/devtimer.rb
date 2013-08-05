class DevTimer
  def initialize(pid_file=nil)
    @pid_file = pid_file
  end
  
  def start(duration='15m')
    if running?
      puts "Timer already running."
    else
      seconds = duration_to_seconds(duration)
      puts "Setting timer for #{seconds} seconds"
      new_pid = fork do 

        exec "sleep #{seconds} && say 'STAND UP!' && rm #{@pid_file}"

      end
      File.write @pid_file, new_pid
      new_pid
    end
  end
  
  def status
    puts running? ? "Timer running with pid #{pid}" : "Timer not running."
  end
  
  def stop
    if running?
      Process.kill 9, pid
      File.delete(@pid_file)
      puts "Timer stopped."
    else
      puts "Timer not running."
    end
  end
  
  def running?
    File.exists?(@pid_file)
  end

  def pid
    File.read(@pid_file).to_i
  end
  
  private
  
  def duration_to_seconds(duration)
    if duration =~ /^(\d+)m$/
      seconds = $1.to_i * 60
    elsif duration =~ /^(\d+)h$/
      seconds = $1.to_i * 60 * 60
    elsif duration =~ /^(\d+)s?$/
      seconds = $1.to_i
    else
      raise ArgumentError, "Illegal duration: #{duration}"
    end
  end
end
