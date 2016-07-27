require 'yaml'

require 'minikiq/cli/project'
require 'minikiq/hash_constants'

module Minikiq
  FILE = File.expand_path('.minikiq')
  module CLI
    class Run
      def initialize
        @projects = {}
        load_file
        load_projects
      end

      def add(project)
        if project_exists?(project)
          puts "ERROR: That project already exists!\n\n"
          help
        else
          display_and_add(project)
        end
      end

      def display_and_add(project)
        name = project[1]
        amount = project[2]
        @projects[name] = Project.new(name, amount)
        save
        puts "Added Project: #{name}!"
      end

      def project_exists?(project)
        !@projects[project[1]].nil?
      end


      def back(project)
        backer_name = project[1]
        project_name = project[2]
        credit_card = project[3]
        amount = project[4]
        project = @projects[project_name]
        puts project.inspect
        project.amount = project.amount.to_i - amount.to_i
        project.backers[credit_card] = [backer_name, project_name, amount]
        save
      end

      #
      # Takes a project name
      # Print all the backers for a given project
      # Returns nothing
      #
      def list_projects(project_name)
        project = Project.all_offspring.find { |p| p.name == project_name }
        puts "Project Name: #{project.name}"
        puts "Amount Remaining: #{project.amount}"
        project.backers.each do |backer|
          puts "Backer #{backer[1][0]}, Amount: #{backer[1][2]}, Credit Card: #{backer[0]}"
        end
      end

      def list_backed_projects(backer_name)
        @projects.each do |project|
          project[1].backers.each do |backer|
            if backer[1][0] == backer_name
              puts "Backed #{project[1].name} for #{backer[1][2]} dollars on credit card number #{backer[0]}."
            end
          end
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
          contents = YAML.load_file(@file)
          contents.keys.each do |d|
            @projects[d] = Project.new(contents[d].name, contents[d].amount, contents[d].backers)
          end
        end
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
          back(input)
        when "list"
          list_projects(input[1])
        when "backer"
          list_backed_projects(input[1])
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
