require 'mixlib/shellout'

def print_usage(args)
	puts "Usage:\n\t#{$0} query :: <command> | <run_iterations> [remove_iterations]\n"
end

def test_command(args)
	if args.length < 1 
    	print_usage(args)
    	exit 1
  	end
  	
  	run_iterations = 1
	@times = []
	run_iterations = args[1].to_i if args[1]

	print_results(timing_test(args[0],run_iterations,args[2]))
end

def timing_test(args,iterations,remove_iterations)
	iterations.times do
		start = Time.now 
		command = Mixlib::ShellOut.new(args[0])
		command.run_command
		finish = Time.now
		@times << (finish - start)
	end
	@times.slice!(remove_iterations.to_i..-1)
end

def print_results(times)
	if times.count > 1
		times.each {|time| puts "#{time} seconds" }
		puts "Average runtime is #{average(times).round(4)} seconds"
		puts "Slowest runtime is #{times.max} seconds"
		puts "Fastest runtime is #{times.min} seconds"
	else
		puts "#{times.join} seconds"
	end
end

def average(times)
	times.inject(:+) / times.length
end


if __FILE__ == $0
  test_command(ARGV)
end
