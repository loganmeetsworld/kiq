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
    end
  end
end