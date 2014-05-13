require 'mixlib/shellout'

def test_command(args)
	times = []
	args[1].to_i.times do
		start = Time.now 
		command = Mixlib::ShellOut.new(args[0])
		command.run_command
		finish = Time.now
		times << (finish - start)
	end
	puts times
	puts "Average time is #{average(times)} seconds"
end

def average(times)
	times.inject(:+) / times.length
end

if __FILE__ == $0
  test_command(ARGV)
end
