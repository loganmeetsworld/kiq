require 'optparse'
require 'yaml'

require 'minikiq/cli/project'
require 'minikiq/hash_constants'

module Minikiq
  FILE = File.expand_path('.minikiq')
  module CLI
    class Run
    def initialize
      @projects = []
      @options = {}
      load_file
      load_projects
    end

    #
    # Creates a new project
    # Returns the item added
    #
    def add(project)
      @projects << [Project.new(project)]
      save
      puts "Just added #{@projects.last}!"
    end

    #
    # Print all the projects
    # Returns nothing
    #
    def list_projects
      @projects.each_with_index do |project, index|
        puts "#{(index + 1).to_s}" + ". Name: #{project[0].name}" + ", Amount: #{project[0].amount}"
      end
    end

    #
    # Access the project list file
    # Returns file path
    #
    def file
      @file ||= File.exist?(FILE) ? FILE : '.minikiq'
    end

    #
    # Loads existing projects from yaml to @projects
    # Returns @projects hash.
    #

    def load_projects
      unless File.zero?(@file)
        YAML.load_file(@file).each do |d|
          @projects << [Project.new(['project', d[0].name, d[0].amount])]
        end
      end
      @projects
    end

    #
    # Saves projects hash in yaml
    # Returns nothing
    #
    def save
      File.open(file, "w") {|f| f.write(@projects.to_yaml) }
    end

    #
    # Check if file exists, save if not
    # Returns nothing
    #
    def load_file
      File.exist?(file) ? return : save
    end

    def perform
      input = ARGV
      first_word = input[0]
      valid_input = ['project', 'list', 'back', 'backer']

      case first_word
      when *valid_input
        handle(input)
      when '-v'
        puts Minikiq::VERSION
      when nil
        help
      when '--help'
        help
      else
        puts "Unknown command: '#{input}'." unless input == '-h'
        help
      end
    end

    def handle(input)
      case input[0]
      when "project"
        if input[-1] == '--help'
          return command_help('project')
        end
        if validate_project(input) == true
          add(input)
        else
          help
        end
      when "back"
        Command::BackProject.run(input)
      when "list"
        list_projects()
      when "backer"
        Command::ListContributions.run(input)
      end
    end

    def validate_project(input)
      check_input_length(input)
      if check_input_length(input)
        check_name_characters(input[1])
        check_name_length(input[1])
        check_amount(input[2])
      else
        command_help(input[0])
      end
    end

    def check_input_length(input)
      if input.length == 3
        return true
      else
        return false
      end
    end

    def check_name_characters(name)
      if name.scan(/[^\w-]/).empty?
        return true
      else
        puts 'ERROR: Project name may only use alphanumeric characters, underscores, and dashes.'
        return false
      end
    end

    def check_name_length(name)
      if name.length >= 4 && name.length <= 20
        return true
      else
        puts 'Project name must be between 4 and 20 characters.'
      end
    end

    def check_amount(amount)
      if !amount.include?('$')
        return true
      else
        puts 'Project amount must not contain the "$" character or any other alphanumeric characters. Numbers only.'
        return false
      end
    end

    def help
      Minikiq::TITLE_HASH.keys.each do |key|
        puts key
        puts '    ' + Minikiq::TITLE_HASH[key]
      end

      puts 'GLOBAL OPTIONS'
      puts "    --help   - Get help for a command\n\n"

      puts "COMMANDS"
      Minikiq::COMMAND_HASH.keys.each do |key|
        puts '    ' + key + Minikiq::COMMAND_HASH[key][0]
      end
      puts "\n"
    end

    def command_help(command)
      puts 'NAME'
      puts '    ' + Minikiq::TITLE_HASH['NAME']
      puts 'SYNOPSIS'
      puts '    ' + command + '    ' + Minikiq::COMMAND_HASH[command][1]
    end
  end
  end
end
