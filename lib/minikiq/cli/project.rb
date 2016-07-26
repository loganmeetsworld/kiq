module Minikiq
  module CLI
    class Project
      attr_accessor :name, :amount

      def initialize(project)
        @name = project[1]
        @amount = project[2]
      end

      def to_s
        "#{@name}: #{@amount.to_s}"
      end
    end
  end
end