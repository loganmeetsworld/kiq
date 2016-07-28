require 'spec_helper'

RSpec.describe Minikiq::CLI::Run do
  it 'can initialize a run' do
    expect( Minikiq::CLI::Run.new).to_not eq nil
  end

  describe '#add(project)' do
    project = ['project', 'RandomProject', '300']
    Minikiq::CLI::Run.new.add(project)
    projects = { 'RandomProject' => Minikiq::CLI::Project.all_offspring.first }

    it 'adds a project' do
      expect(Minikiq::CLI::Project.project_exists?('RandomProject', projects)).to eq true
    end
  end
end
