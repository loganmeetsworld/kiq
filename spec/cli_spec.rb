require 'spec_helper'

describe Minikiq::CLI do
  describe '#run' do
    it 'should return test' do
      cli = Minikiq::CLI.new
      expect(cli.run).to eq 'test'
    end
  end
end
