require 'spec_helper'

RSpec.describe Kiq::CLI::Project do

  describe '#self.all_offspring' do
    it 'returns all the instances of project class' do
      Kiq::CLI::Project.new('Test', '300', {})
      expect(Kiq::CLI::Project.all_offspring.length).to_not eq 0
    end
  end

  context 'validating a project' do
    describe 'self.project_does_not_exist?(project, projects)' do
      Kiq::CLI::Project.new('Test', '300', {})
      projects = {'Test' => Kiq::CLI::Project.all_offspring.first}
      good_project = ['project', 'NotTest']
      bad_project = ['project', 'Test']

      it 'returns true if a project does not exist' do
        expect(Kiq::CLI::Project.project_does_not_exist?(good_project, projects)).to eq true
      end

      it 'returns false if a project does not exist' do
        expect(Kiq::CLI::Project.project_does_not_exist?(bad_project, projects)).to eq false
      end
    end

    describe 'self.check_amount_dollar_sign(amount)' do
      good_amount = '400'
      bad_amount = '$400'
      it 'returns true if amount has no dollar sign' do
        expect(Kiq::CLI::Project.check_amount_dollar_sign(good_amount)).to eq true
      end

      it 'returns false if amount has dollar sign' do
        expect(Kiq::CLI::Project.check_amount_dollar_sign(bad_amount)).to eq false
      end
    end

    describe 'self.check_input_length(input)' do
      short_input = ['Test', 'One']
      long_input = ['Test', 'One', 'Two', 'Three']
      good_input = ['Test', 'One', 'Two']

      it 'returns true if correct number of args' do
        expect(Kiq::CLI::Project.check_input_length(good_input)).to eq true
      end

      it 'returns false if incorrect number of args' do
        expect(Kiq::CLI::Project.check_input_length(short_input)).to eq false
        expect(Kiq::CLI::Project.check_input_length(long_input)).to eq false
      end
    end

    describe 'self.check_name_characters(name)' do
      good_name = 'good_name-'
      bad_name = 'bad name'
      it 'returns true if name has correct chacters' do
        expect(Kiq::CLI::Project.check_name_characters(good_name)).to eq true
      end

      it 'returns false if name does not have correct chacters' do
        expect(Kiq::CLI::Project.check_name_characters(bad_name)).to eq false
      end
    end

    describe 'self.check_name_length(name)' do
      long_name = 'abcdefghijklmnopqrstuvwxyz'
      short_name = 'abc'
      good_name = 'justright'

      it 'returns true if name is between 4 and 20 characters long' do
        expect(Kiq::CLI::Project.check_name_length(good_name)).to eq true
      end

      it 'returns false if name is not between 4 and 20 characters long' do
        expect(Kiq::CLI::Project.check_name_length(short_name)).to eq false
        expect(Kiq::CLI::Project.check_name_length(long_name)).to eq false
      end
    end
  end
end
