module Minikiq
  class Display
    def self.help
      Minikiq::TITLE_HASH.keys.each do |key|
        puts key
        puts Minikiq::SPACES + Minikiq::TITLE_HASH[key]
      end

      puts 'GLOBAL OPTIONS'
      puts Minikiq::SPACES + Minikiq::GLOBAL_COMMAND

      puts "COMMANDS"
      Minikiq::COMMAND_HASH.keys.each do |key|
        puts Minikiq::SPACES + key + Minikiq::COMMAND_HASH[key][0]
      end
      puts "\n"
    end

    def self.command_help(command)
      puts 'NAME'
      puts Minikiq::SPACES + Minikiq::TITLE_HASH['NAME']
      puts 'SYNOPSIS'
      puts Minikiq::SPACES + command + Minikiq::SPACES + Minikiq::COMMAND_HASH[command][1]
    end
  end
end