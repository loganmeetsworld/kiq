require 'yaml'
require 'minikiq/project'
require 'minikiq/hash_constants'
require 'minikiq/display'

module Minikiq
  FILE = File.expand_path('.minikiq')
  module CLI
    class Run
      def initialize
        @projects = {}
        load_file
        load_projects
      end

      def file
        @file ||= File.exist?(FILE) ? FILE : '.minikiq'
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

      def load_file
        File.exist?(file) ? return : save
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
          Minikiq::Display.help
        when '--help'
          Minikiq::Display.help
        else
          puts "Unknown command: '#{user_input}'." unless input == '-h'
          Minikiq::Display.help
        end
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

      def check_luhn_10(card)
        digits = card.chars.map(&:to_i)
        check = digits.pop

        sum = digits.reverse.each_slice(2).flat_map do |x, y|
          [(x * 2).divmod(10), y || 0]
        end.flatten.inject(:+)

        (10 - sum % 10) == check
      end

      def check_card_length(card)
        return card.length <= 19
      end

      def check_card_numeric(card)
        Float(card) != nil rescue false
      end

      def back(project)
        backer_name = project[1]
        project_name = project[2]
        credit_card = project[3]
        amount = project[4]
        project = @projects[project_name]
        if project.backers[credit_card].nil?
          project.backers[credit_card] = [backer_name, project_name, amount]
        else
          return "ERROR: That card has already been added by another user!"
        end

        project.amount = project.amount.to_f - amount.to_f

        if project.amount <= 0
          puts "Reached goal!"
        end

        save
      end

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

      def handle(input)
        case input[0]
        when "project"
          if input[-1] == '--help'
            return Minikiq::Display.command_help('project')
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
          check_name_characters(input[0], input[1])
          check_name_length(input[0], input[1])
          check_amount(input[0], input[2])
        else
          Minikiq::Display.command_help(input[0])
        end
      end

      def check_input_length(input)
        if input.length == 3
          return true
        else
          return false
        end
      end

      def check_name_characters(type, name)
        if name.scan(/[^\w-]/).empty?
          return true
        else
          puts "ERROR: #{type} name may only use alphanumeric characters, underscores, and dashes."
          return false
        end
      end

      def check_name_length(type, name)
        if name.length >= 4 && name.length <= 20
          return true
        else
          puts "#{type} name must be between 4 and 20 characters."
        end
      end

      def check_amount(type, amount)
        if !amount.include?('$')
          return true
        else
          puts "#{type} amount must not contain the '$' character or any other alphanumeric characters. Numbers only."
          return false
        end
      end

    end
  end
end