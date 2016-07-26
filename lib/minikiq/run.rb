require 'optparse'

require 'minikiq/commands/add_project'
require 'minikiq/commands/back_project'
require 'minikiq/commands/list_contributions'
require 'minikiq/commands/errors'
require 'minikiq/commands/list_backers'


module Minikiq
  class CLI
    def run
      user_input = ARGV.shift
      valid_input = ['project', 'list', 'back', 'backer']

      case user_input
      when *valid_input
        puts user_input
      when '-v'
        puts Minikiq::VERSION
      else
        puts "Unknown command: '#{user_input}'." unless user_input == '-h'
        home
      end
    end

    private

    def home
      command_descriptions = Hash[
        :list => '   => Lists all projects',
        :back => '   => Backs a project',
        :project => '=> Lists all backers for a project',
        :backer => ' => Lists all projects for a backer'
      ]
      puts "minikiq [project|back|backers|list] [command]"
      puts "Append -h for help on specific command.\n\n"
      command_descriptions.keys.each do |command|
        puts "  - #{command} #{command_descriptions[command]}"
      end
    end
  end
end
