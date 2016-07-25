require 'spec_helper'

describe Minikiq::CLI do
  describe '#run' do
    it "should display help if the target does not exist" do
      ARGV.should_receive(:shift).and_return('nothing_to_see_here')

      cli = Minikiq::CLI.new
      expect(cli).to receive(:puts).with "Unknown command: 'nothing_to_see_here'."
      expect(cli).to receive(:puts).with "minikiq [project|back|backers|list] [command]"
      expect(cli).to receive(:puts).with "Append -h for help on specific command.\n\n"
      expect(cli).to receive(:puts).with "  - list    => Lists all projects"
      expect(cli).to receive(:puts).with "  - back    => Backs a project"
      expect(cli).to receive(:puts).with "  - project => Lists all backers for a project"
      expect(cli).to receive(:puts).with "  - backer  => Lists all projects for a backer"
      cli.run
    end
  end
end
