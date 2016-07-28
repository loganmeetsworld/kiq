module Kiq
  # Displays help to the user
  class Display
    # Returns the full help center
    # @return [String]
    def self.help
      Kiq::TITLE_HASH.keys.each do |key|
        puts key
        puts Kiq::SPACES + Kiq::TITLE_HASH[key]
      end

      puts 'GLOBAL OPTIONS'
      puts Kiq::SPACES + Kiq::GLOBAL_COMMAND

      puts "COMMANDS"
      Kiq::COMMAND_HASH.keys.each do |key|
        puts Kiq::SPACES + key + Kiq::COMMAND_HASH[key][0]
      end
      puts "\n"
    end

    # @param command [String]
    # Returns the command help center
    # @return [String]
    def self.command_help(command)
      puts 'NAME'
      puts Kiq::SPACES + Kiq::TITLE_HASH['NAME']
      puts 'SYNOPSIS'
      puts Kiq::SPACES + command + Kiq::SPACES + Kiq::COMMAND_HASH[command][1]
    end
  end
end