require 'spec_helper'

RSpec.describe Minikiq::CLI::Run do
  let(:minikiq) { Minikiq::CLI::Run.new }
  it 'can initialize a run' do
    expect(minikiq).to_not eq nil
  end

  describe '#add(project)' do
    it 'adds a project' do
      project = ['project', 'RandomProject', '300']
      minikiq.add(project)
      projects = { 'RandomProject' => Minikiq::CLI::Project.all_offspring.first }
      expect(Minikiq::CLI::Project.project_exists?('RandomProject', projects)).to eq true
    end
  end

  describe '#back(type, backer_name, project_name, credit_card, amount)' do
    it 'backs a project' do
      credit_card = '4111111111111111'
      backer_name = 'Logan'
      project_name = 'RandomProject'
      minikiq.back('project', backer_name, project_name, credit_card, '40')
      project = Minikiq::CLI::Project.all_offspring.find { |p| p.name == project_name }
      expect(project.backers.values.first.name).to eq backer_name
    end
  end
end
