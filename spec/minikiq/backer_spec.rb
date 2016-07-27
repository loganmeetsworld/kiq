require 'spec_helper'

RSpec.describe Minikiq::CLI::Backer do
  context 'validate a project' do
    describe '#self.validate_project_exists(project)' do
      project =  Minikiq::CLI::Project.new('Test', '300', {})
      non_existant_project = nil
      it 'returns true if a project exists' do
        expect(Minikiq::CLI::Backer.validate_project_exists(project)).to eq true
      end
      it 'returns false if a project does not exist' do
        expect(Minikiq::CLI::Backer.validate_project_exists(non_existant_project)).to eq false
      end
    end
  end

  context 'validate a card' do
    describe 'self.check_card_uniqueness(project, credit_card)' do
      it '' do
      end

      it '' do
      end
    end

    describe 'self.self.check_card_luhn_10(credit_card)' do
      it '' do
      end

      it '' do
      end
    end

    describe 'self.check_card_length(credit_card)' do
      it '' do
      end

      it '' do
      end
    end

    describe 'self.check_card_numeric(credit_card)' do
      it '' do
      end

      it '' do
      end
    end
  end

  context 'validate a backer name' do
    describe 'self.check_name_characters(name)' do
      good_name = 'good_name-'
      bad_name = 'bad name'
      it 'returns true if name has correct chacters' do
        expect(Minikiq::CLI::Backer.check_name_characters(good_name)).to eq true
      end

      it 'returns false if name does not have correct chacters' do
        expect(Minikiq::CLI::Backer.check_name_characters(bad_name)).to eq false
      end
    end

    describe 'self.check_name_length(name)' do
      long_name = 'abcdefghijklmnopqrstuvwxyz'
      short_name = 'abc'
      good_name = 'justright'

      it 'returns true if name is between 4 and 20 characters long' do
        expect(Minikiq::CLI::Backer.check_name_length(good_name)).to eq true
      end

      it 'returns false if name is not between 4 and 20 characters long' do
        expect(Minikiq::CLI::Backer.check_name_length(short_name)).to eq false
        expect(Minikiq::CLI::Backer.check_name_length(long_name)).to eq false
      end
    end
  end

  context 'validate an amount' do
    describe 'self.check_amount_dollar_sign(amount)' do
      good_amount = '400'
      bad_amount = '$400'
      it 'returns true if amount has no dollar sign' do
        expect(Minikiq::CLI::Backer.check_amount_dollar_sign(good_amount)).to eq true
      end

      it 'returns false if amount has dollar sign' do
        expect(Minikiq::CLI::Backer.check_amount_dollar_sign(bad_amount)).to eq false
      end
    end
  end
end
