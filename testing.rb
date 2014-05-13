require 'mixlib/shellout'

def test_command(args)
	times = []
	args[1] = 1 if args.count == 1
	args[1].to_i.times do
		start = Time.now 
		command = Mixlib::ShellOut.new(args[0])
		command.run_command
		finish = Time.now
		times << (finish - start)
	end
	puts "Average time is #{average(times).round(4)} seconds"
	puts "Peak time is #{times.max} seconds"
	puts "Fastest time is #{times.min} seconds"
end

def average(times)
	times.inject(:+) / times.length
end


if __FILE__ == $0
  test_command(ARGV)
end
