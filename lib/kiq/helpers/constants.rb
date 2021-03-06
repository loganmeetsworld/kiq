require 'kiq/helpers/version'

# Contains all relevant constants for displaying information
module Kiq
  TITLE_HASH = {
    'NAME' => "kiq: a command line interface for backing Kickstarter projects.\n\n",
    'SYNOPSIS' => "kiq [command] [arguments...]\n\n",
    'VERSION' => "#{Kiq::VERSION}\n\n"
  }
  COMMAND_HASH = {
    'list' => ['     - Display a project including backers and backed amounts', '[project name]'],
    'project' => ['  - Create a new project', '[project name] [amount]'],
    'back' => ['     - Back a project', '[backer name] [project name] [credit card number] [backing amount]'],
    'backers' => ['  - Display a list of projects that a backer has backed and amounts backed', '[backer name]']
  }

  SPACES = '    '

  GLOBAL_COMMAND = "--help   - Get help for a command\n\n"
end
