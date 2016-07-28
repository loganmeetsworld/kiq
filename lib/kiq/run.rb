require 'yaml'
require 'kiq/project'
require 'kiq/backer'
require 'kiq/helpers/constants'
require 'kiq/helpers/display'

module Kiq
  FILE = File.expand_path('.kiq')
  module CLI
    # Runs the program when the user types 'kiq'
    class Run
      # Initialize the Run with a projects hash and load the file
      def initialize
        @projects = {}
        load_file
        load_projects
      end

      # Uses user input
      # @return [String] help documentation or handles valid input
      def perform
        user_input      = ARGV
        primary_command = user_input[0]
        valid_commands  = ['project', 'list', 'back', 'backer']

        case primary_command
        when *valid_commands
          handle(user_input)
        when '-v'
          puts Kiq::VERSION
        when nil
          Display.help
        when '--help'
          Display.help
        else
          puts "Unknown command: '#{user_input}'." unless user_input == '-h'
          Display.help
        end
      end

      # Handles valid input
      # Runs relevant method for command
      # Returns help if user input indicates help is needed
      def handle(input)
        if input[-1] == '--help'
          return Display.command_help(input[0])
        end

        case input[0]
        when "project"
          add(input)
        when "back"
          back(input[0], input[1], input[2], input[3], input[4])
        when "list"
          list(input[1])
        when "backer"
          backer(input[1])
        end
      end

      # @param project [Array]
      # Returns successful message if project added
      # Returns help if add is unsuccessful
      def add(project)
        type = project[0]
        name = project[1]
        amount = project[2]

        if Project.validate_project(project, @projects)
          @projects[name] = Project.new(name, amount)
          save
          puts "Added Project: #{name}!"
        else
          Display.command_help(type)
        end
      end

      # @param type [String]
      # @param backer_name [String]
      # @param project_name [String]
      # @param credit_card [String]
      # @param amount [String]
      # @return [String] successful message if user input is valid, help if back is unsuccessful
      def back(type, backer_name, project_name, credit_card, amount)
        project = @projects[project_name]
        if Backer.validate_project_exists(project) && Backer.validate_card(project, credit_card) && Backer.validate_backer_name(backer_name) && Backer.check_amount_dollar_sign(amount)
          backer = Backer.new(backer_name, credit_card, amount)
          project.backers[credit_card] = backer
          update_goal(project, amount)
          save
          puts "#{backer.name.capitalize} backed #{project_name} for $#{backer.amount}."
        else
          Display.command_help(type)
        end
      end

      # @param project_name [String]
      # If Project instance exists, lists all backers for a certain project
      # @return [String] of backers, or error and help if project does not exist
      def list(project_name)
        if !Project.project_does_not_ exist?(['project', project_name], @projects)
          project = Project.all_offspring.find { |p| p.name == project_name }
          puts "Project Name: #{project.name}"
          puts "Amount Remaining: $#{project.amount}"
          check_goal(project)
          puts "BACKERS:"
          project.backers.each do |backer|
            puts "Backer #{backer[1].name}, Amount: $#{backer[1].amount}"
          end
        else
          puts "ERROR: Project does not exist.\n\n"
          Display.help
        end
      end

      # @param backer_name [String]
      # Lists projects backed by a certain backer
      # @return [String] of projects, or nothing if none exist
      def backer(backer_name)
        @projects.each do |project|
          project[1].backers.each do |backer|
            if backer[1].name == backer_name
              puts "Backed #{project[1].name} for $#{backer[1].amount} dollars"
            end
          end
        end
      end

      private

      # Accessor for the project list file
      # Returns the file path
      def file
        @file ||= File.exist?(FILE) ? FILE : '.kiq'
      end

      # Creates a new project file if none exists
      # Returns nothing
      def load_file
        File.exist?(file) ? return : save
      end

      # Loads the yaml projects file and creates a projects hash
      # Returns nothing
      def load_projects
        unless File.zero?(@file)
          contents = YAML.load_file(@file)
          contents.keys.each do |d|
            @projects[d] = Project.new(contents[d].name, contents[d].amount, contents[d].backers)
          end
        end
      end

      # Saves the current list of projects to the yaml file (serialization)
      # Returns nothing
      def save
        File.open(file, "w") {|f| f.write(@projects.to_yaml) }
      end

      # Updates project goal
      # Returns check_goal if goal is met
      def update_goal(project, amount)
        project.amount = project.amount.to_f - amount.to_f
        check_goal(project)
      end

      # Checks if project amount has met the goal
      # @return [String] success message if goal met, else returns nothing
      def check_goal(project)
        if project.amount.to_i <= 0
          puts "Reached goal!"
        end
      end
    end
  end
end