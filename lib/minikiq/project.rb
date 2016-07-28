module Minikiq
  module CLI
    class Project
      @@instance_collector = []
      attr_accessor :name, :amount, :backers

      # Initialize a project object with name and amount
      # Sets backers to empty default
      # Collects instantiated objects
      def initialize(name, amount, backers={})
        @name = name
        @amount = amount
        @backers = backers
        @@instance_collector << self
      end

      # Sets up easy was to call all instances of an object
      # Returns instances
      def self.all_offspring
        @@instance_collector
      end

      # Takes a project [Array] and all Project instances [Project]
      # Calls all validation methods for a given project
      # Returns boolean
      def self.validate_project(project, projects)
        type = project[0]
        name = project[1]
        amount = project[2]

        return self.check_input_length(project) && self.project_does_not_exist?(project, projects) && self.check_amount_dollar_sign(amount) && self.check_name_characters(name) && self.check_name_length(name)
      end

      # Takes a project [Array] and all Project instances [Project]
      # Checks if project already exists
      # Returns boolean and warning if false
      def self.project_does_not_exist?(project, projects)
        if projects[project[1]].nil?
          return true
        else
          puts "ERROR: Project already exists."
          return false
        end
      end

      # Takes in amount [String]
      # Checks if the amount includes dollar signs
      # Returns boolean and warning if false
      def self.check_amount_dollar_sign(amount)
        if !amount.include?('$')
          return true
        else
          puts "ERROR: Project amount must not contain the '$' character or any other alphanumeric characters. Numbers only."
          return false
        end
      end

      # Takes in full user input [Array]
      # Checks if the array is the correct length for project input
      # Returns boolean and warning if false
      def self.check_input_length(input)
        if input.length == 3
          return true
        else
          puts "ERROR: A project must have two arguments."
          return false
        end
      end

      # Takes in name [String]
      # Checks if the amount includes dollar signs
      # Returns boolean and warning if false
      def self.check_name_characters(name)
        if name.scan(/[^\w-]/).empty?
          return true
        else
          puts "ERROR: Project name may only use alphanumeric characters, underscores, and dashes."
          return false
        end
      end

      # Takes in name [String]
      # Checks if the string is between 4 and 20 characters
      # Returns boolean and warning if false
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