require 'spec_helper'

RSpec.describe Minikiq::CLI::Project do
  describe '#self.all_offspring' do
    it 'returns all the instances of project class' do
      Minikiq::CLI::Project.new('Test', '300', {})
      expect(Minikiq::CLI::Project.all_offspring.length).to_not eq 0
    end
  end

  context 'validating a project' do
    Minikiq::CLI::Project.new('Test', '300', {})
    projects = {'Test' => Minikiq::CLI::Project.all_offspring.first}
    project = ['project', 'NotTest']
    describe 'self.project_exists?(project, projects)' do
      it 'returns true if a project does not exist' do
        expect(Minikiq::CLI::Project.project_exists?(project, projects)).to eq true
      end
    end
  end
end
