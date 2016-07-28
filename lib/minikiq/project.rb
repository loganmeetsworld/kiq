module Minikiq
  module CLI
    class Project
      @@instance_collector = []
      attr_accessor :name, :amount, :backers

      def initialize(name, amount, backers={})
        @name = name
        @amount = amount
        @backers = backers
        @@instance_collector << self
      end

      def self.all_offspring
        @@instance_collector
      end

      def self.validate_project(project, projects)
        type = project[0]
        name = project[1]
        amount = project[2]

        return self.check_input_length(project) && self.project_exists?(project, projects) && self.check_amount_dollar_sign(amount) && self.check_name_characters(name) && self.check_name_length(name)
      end

      def self.project_exists?(project, projects)
        if projects[project[1]].nil?
          return true
        else
          puts "ERROR: Project already exists."
          return false
        end
      end

      def self.check_amount_dollar_sign(amount)
        if !amount.include?('$')
          return true
        else
          puts "ERROR: Project amount must not contain the '$' character or any other alphanumeric characters. Numbers only."
          return false
        end
      end

      def self.check_input_length(input)
        if input.length == 3
          return true
        else
          puts "ERROR: A project must have two arguments."
          return false
        end
      end

      def self.check_name_characters(name)
        if name.scan(/[^\w-]/).empty?
          return true
        else
          puts "ERROR: Project name may only use alphanumeric characters, underscores, and dashes."
          return false
        end
      end

      def self.check_name_length(name)
        if name.length >= 4 && name.length <= 20
          return true
        else
          puts "ERROR: Project name must be between 4 and 20 characters."
          return false
        end
      end
    end
  end
end