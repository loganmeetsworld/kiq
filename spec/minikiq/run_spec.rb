require 'spec_helper'

RSpec.describe Minikiq::CLI::Run do
  it 'can initialize a run' do
    minikiq = Minikiq::CLI::Run.new
    expect(minikiq).to_not eq nil
  end

  describe '#perform' do
    it 'receives user input' do
    end

    it 'displays help when nil' do
    end

    it 'displays help when command unknown' do
    end

    it 'displays help when help is called' do
    end
  end

  describe '#handle' do
  end

  describe '#add(project)' do
  end

  describe '#back(type, backer_name, project_name, credit_card, amount)' do
  end

  describe '#list(project_name)' do
  end

  describe '#backer(backer_name)' do
  end
end
