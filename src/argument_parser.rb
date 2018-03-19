require "optparse"

class ArgumentParser
  def self.parse(argv)
    parsed_options = {
      key: "",
      specify_password: false,
      action: ""
    }

    option_parser = OptionParser.new do |options|
      options.banner =
        "Usage: key-box [add|get|remove] [KEY] [OPTIONS]..."

      options.on("-p", "--password", "Manually specify the password") do
        parsed_options[:specify_password] = true
      end

      options.on("-h", "--help", "Prints this help") do
        puts(options)
        exit(0)
      end
    end

    begin
      option_parser.parse!(argv)
    rescue OptionParser::ParseError => error_message
      puts("Error: #{error_message}")
      puts(option_parser.help)
      exit(1)
    end

    parsed_options[:action] = argv.shift
    unless ["add", "remove", "get"].include?(parsed_options[:action])
      puts("Error: unknown action: #{parsed_options[:action] || "<EMPTY>"}")
      puts(option_parser.help)
      exit(1)
    end

    parsed_options[:key] = argv.shift
    unless parsed_options[:key] && parsed_options[:key] != ""
      puts("Error: key not specified")
      puts(option_parser.help)
      exit(1)
    end

    return parsed_options
  end
end
