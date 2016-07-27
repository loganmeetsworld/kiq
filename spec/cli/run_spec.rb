require 'spec_helper'

describe 'Minikiq::CLI::Run' do
  it 'can initialize a run' do
    minikiq = Minikiq::CLI::Run.new
    expect(minikiq).to_not eq nil
  end

  it 'adds a project' do
    minikiq = Minikiq::CLI::Run.new
    minikiq.add(['project', 'test', '200'])
    expect(minikiq.load_projects.first).to eq 'test'
  end
end
