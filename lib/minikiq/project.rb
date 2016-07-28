module Minikiq
  module CLI
    # Hosts logic for the backer object
    class Project
      @@instance_collector = []
      # Allows access to name, amount, and backers
      attr_accessor :name, :amount, :backers

      # @param name [String]
      # @param amount [String]
      # @param backers [Hash]
      # @instance_collector [Array]
      # Initialize a project object with name and amount
      def initialize(name, amount, backers={})
        @name = name
        @amount = amount
        @backers = backers
        @@instance_collector << self
      end

      # Sets up easy was to call all instances of an object
      # @return instances
      def self.all_offspring
        @@instance_collector
      end

      # @param project [Array] the user input for project
      # @param projects [Array] all instances of Project
      # Calls all validation methods for a given project
      # @return [Boolean]
      def self.validate_project(project, projects)
        name = project[1]
        amount = project[2]

        return self.check_input_length(project) && self.project_does_not_exist?(project, projects) && self.check_amount_dollar_sign(amount) && self.check_name_characters(name) && self.check_name_length(name)
      end

      # @param project [Array] the user input for project
      # @param projects [Array] all instances of Project
      # Checks if project already exists
      # @return [Boolean] warning if false
      def self.project_does_not_exist?(project, projects)
        if projects[project[1]].nil?
          return true
        else
          puts "ERROR: Project already exists."
          return false
        end
      end

      # @param amount [String]
      # Checks if the amount includes dollar signs
      # @return [Boolean] warning if false
      def self.check_amount_dollar_sign(amount)
        if !amount.include?('$')
          return true
        else
          puts "ERROR: Project amount must not contain the '$' character or any other alphanumeric characters. Numbers only."
          return false
        end
      end

      # @param input [Array] full user input
      # Checks if the array is the correct length for project input
      # @return [Boolean] warning if false
      def self.check_input_length(input)
        if input.length == 3
          return true
        else
          puts "ERROR: A project must have two arguments."
          return false
        end
      end

      # @param name [String]
      # Checks if the name has non-alphanumeric characters besides underscores and dashes
      # @return [Boolean] warning if false
      def self.check_name_characters(name)
        if name.scan(/[^\w-]/).empty?
          return true
        else
          puts "ERROR: Project name may only use alphanumeric characters, underscores, and dashes."
          return false
        end
      end

      # @param name [String]
      # Checks if the string is between 4 and 20 characters
      # @return [Boolean] warning if false
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