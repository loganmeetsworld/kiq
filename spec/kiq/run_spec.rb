require 'spec_helper'

RSpec.describe Kiq::CLI::Run do
  it 'can initialize a run' do
    expect( Kiq::CLI::Run.new).to_not eq nil
  end

  describe '#add(project)' do
    project = ['project', 'RandomProject', '300']
    Kiq::CLI::Run.new.add(project)
    projects = { 'RandomProject' => Kiq::CLI::Project.all_offspring.first }

    it 'adds a project' do
      expect(Kiq::CLI::Project.project_does_not_exist?('RandomProject', projects)).to eq true
    end
  end
end
