require 'yaml'
require 'minikiq/project'
require 'minikiq/backer'
require 'minikiq/helpers/constants'
require 'minikiq/helpers/display'

module Minikiq
  FILE = File.expand_path('.minikiq')
  module CLI
    class Run
      def initialize
        @projects = {}
        load_file
        load_projects
      end

      def perform
        user_input      = ARGV
        primary_command = user_input[0]
        valid_commands  = ['project', 'list', 'back', 'backer']

        case primary_command
        when *valid_commands
          handle(user_input)
        when '-v'
          puts Minikiq::VERSION
        when nil
          Display.help
        when '--help'
          Display.help
        else
          puts "Unknown command: '#{user_input}'." unless user_input == '-h'
          Display.help
        end
      end

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

      def list(project_name)
        if !Project.project_exists?(['project', project_name], @projects)
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

      def backer(backer_name)
        @projects.each do |project|
          project[1].backers.each do |backer|
            if backer[1].name == backer_name
              puts "Backed #{project[1].name} for $#{backer[1].amount} dollars"
            end
          end
        end
      end

      def file
        @file ||= File.exist?(FILE) ? FILE : '.minikiq'
      end

      def load_file
        File.exist?(file) ? return : save
      end

      def load_projects
        unless File.zero?(@file)
          contents = YAML.load_file(@file)
          contents.keys.each do |d|
            @projects[d] = Project.new(contents[d].name, contents[d].amount, contents[d].backers)
          end
        end
      end

      def save
        File.open(file, "w") {|f| f.write(@projects.to_yaml) }
      end

      def update_goal(project, amount)
        project.amount = project.amount.to_f - amount.to_f
        check_goal(project)
      end

      def check_goal(project)
        if project.amount.to_i <= 0
          puts "Reached goal!"
        end
      end
    end
  end
end