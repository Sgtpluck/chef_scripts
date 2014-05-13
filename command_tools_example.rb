require  "c:/src/ohai/lib/ohai/util/wmi"
 
def print_usage(args)
  puts "Usage:\n\t#{$0} query | --class class_name [--namespace namespace] [--first]\n"
end
 
def print_usage_and_exit(args)
  print_usage(args)
  exit 1
end
 
def print_results(results)
  results_count = 0
  if ! results.nil?
    if results.is_a? Array
      results.each do | result |
        puts "#{result['name']}"
        puts "#{result.inspect.to_s}"
        results_count += 1
      end
    else
      puts "#{results['name']}"
      puts "#{results.inspect.to_s}"
      results_count += 1
    end
  end
 
  if results_count < 1
    puts "No results."
  end
end
 
 
def run_query(args)
  if args.length < 1 
    print_usage(args)
    exit 1
  end
 
  results = nil
  class_name = nil
  namespace = nil
  first = false
  if args[0] == '--class'
    print_usage_and_exit(args) if args.length < 2
 
    class_name = args[1]
 
    if args.length > 2
      if args[2] == '--first'
        first = true
      elsif args[2] == '--namespace'
        namespace = args[3]
      end
    end
 
    if args.length > 3 && args[4] == '--first'
      first = true
    end
  end
 
  wmi = Ohai::Util::Wmi.new
 
  if class_name
    if first
      results =wmi.first_of(class_name)
    else
      results = wmi.instances_of(class_name)
    end
  else
    results = wmi.query(args[0])
  end
 
  print_results(results)
end
 
if __FILE__ == $0
  run_query(ARGV)
end
