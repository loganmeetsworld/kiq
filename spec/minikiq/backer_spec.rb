require 'spec_helper'

RSpec.describe Minikiq::CLI::Backer do
  let(:backer) { Minikiq::CLI::Backer }
  context 'validate a project' do
    describe '#self.validate_project_exists(project)' do
      project =  Minikiq::CLI::Project.new('Test', '300', {})
      non_existant_project = nil
      it 'returns true if a project exists' do
        expect(backer.validate_project_exists(project)).to eq true
      end
      it 'returns false if a project does not exist' do
        expect(backer.validate_project_exists(non_existant_project)).to eq false
      end
    end
  end

  context 'validate a card' do
    describe 'self.check_card_uniqueness(project, credit_card)' do
      project =  Minikiq::CLI::Project.new('Test', '300', {})
      project_backer = Minikiq::CLI::Backer.new('Jane', '4000', '5555555555554444')
      project.backers = {"5555555555554444"=> project_backer}
      credit_card = "5555555555554444"

      it 'returns false if the card is not new' do
        expect(backer.check_card_uniqueness(project, credit_card)).to eq false
      end
    end

    describe 'self.self.check_card_luhn_10(credit_card)' do
      valid_cards = ['4111111111111111', '378282246310005', '371449635398431', '5610591081018250']
      invalid_cards = ['1234567890123456', ]

      it 'returns true if the card is valid' do
        valid_cards.each do |card|
          expect(backer.check_card_luhn_10(card)).to eq true
        end
      end

      it 'returns false if the card is not valid' do
        invalid_cards.each do |card|
          expect(backer.check_card_luhn_10(card)).to eq false
        end
      end
    end

    describe 'self.check_card_length(credit_card)' do
      valid_card = '123456789'
      invalid_card = '123456789098765432123456'
      it 'returns true if the card is under 19 characters' do
        expect(backer.check_card_length(valid_card)).to eq true
      end

      it 'returns false if the card is not under 19 characters' do
        expect(backer.check_card_length(invalid_card)).to eq false
      end
    end

    describe 'self.check_card_numeric(credit_card)' do
      valid_card = '123456789'
      invalid_cards = ['123fds45678', '3948-3929-34', '_394_']
      it 'returns true if the card is under 19 characters' do
        expect(backer.check_card_numeric(valid_card)).to eq true
      end

      it 'returns false if the card is not under 19 characters' do
        invalid_cards.each do |card|
          expect(backer.check_card_numeric(card)).to eq false
        end
      end
    end
  end

  context 'validate a backer name' do
    describe 'self.check_name_characters(name)' do
      good_name = 'good_name-'
      bad_name = 'bad name'
      it 'returns true if name has correct chacters' do
        expect(backer.check_name_characters(good_name)).to eq true
      end

      it 'returns false if name does not have correct chacters' do
        expect(backer.check_name_characters(bad_name)).to eq false
      end
    end

    describe 'self.check_name_length(name)' do
      long_name = 'abcdefghijklmnopqrstuvwxyz'
      short_name = 'abc'
      good_name = 'justright'

      it 'returns true if name is between 4 and 20 characters long' do
        expect(backer.check_name_length(good_name)).to eq true
      end

      it 'returns false if name is not between 4 and 20 characters long' do
        expect(backer.check_name_length(short_name)).to eq false
        expect(backer.check_name_length(long_name)).to eq false
      end
    end
  end

  context 'validate an amount' do
    describe 'self.check_amount_dollar_sign(amount)' do
      good_amount = '400'
      bad_amount = '$400'
      it 'returns true if amount has no dollar sign' do
        expect(backer.check_amount_dollar_sign(good_amount)).to eq true
      end

      it 'returns false if amount has dollar sign' do
        expect(backer.check_amount_dollar_sign(bad_amount)).to eq false
      end
    end
  end
end
