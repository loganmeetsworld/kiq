
Kiq [![Build Status](https://travis-ci.org/loganmeetsworld/kiq.svg?branch=master)](https://travis-ci.org/loganmeetsworld/kiq) [![Gem Version](https://badge.fury.io/rb/kiq.svg)](https://badge.fury.io/rb/kiq) [![Inline docs](http://inch-ci.org/github/loganmeetsworld/kiq.svg?branch=master)](http://inch-ci.org/github/loganmeetsworld/kiq) [![Code Climate](https://codeclimate.com/github/loganmeetsworld/kiq/badges/gpa.svg)](https://codeclimate.com/github/loganmeetsworld/kiq)
=========

## Summary
Kiq is a crowd funding application that can be run from your command line. This project was a learning experience. Key learning points for me were:
* Building a Ruby gem.
* Struggling with deciding if I should use other gems and build in dependencies.
* Testing Ruby and making code more modular.
* Getting over my Rails addiction.

## Installation
This is a Ruby Gem! It can be found on the rubygems site [here](https://rubygems.org/gems/kiq) and easily implemented on any operating system that has Ruby installed with the command `gem install kiq`.  

I tested this gem out on OSX El Capitan, OSX Yosemite, Microsoft 10, and Linux. Just make sure you have [https://www.ruby-lang.org/en/documentation/installation/](Ruby installed on your OS). RubyGems comes with a Ruby installation.  

This gem uses serialization to store the projects in a `.kiq` yml file. If you don't want this file in whatever folder you are currently in, I would suggest creating a new folder to use the gem: 
``` 
cd projects  
mkdir kiq  
gem install kiq  
```
And then you're off! If you ever want to remove the `.kiq` yaml file, delete it from the folder with:  
`rm .kiq`  

If you're interesting in developing with the code, use git to clone this repo:  
`git clone https://github.com/loganmeetsworld/kiq.git`

## Sample Input and Output
```
> kiq project Awesome_Sauce 500  
Added Project: Awesome_Sauce!  
> kiq back John Awesome_Sauce 4111111111111111 50  
John backed Awesome_Sauce for $50.  
> kiq back Sally Awesome_Sauce 1234567890123456 10  
ERROR: That card fails Luhn-10!  
> kiq back Jane Awesome_Sauce 4111111111111111 50  
ERROR: That card has already been added by another user!  
> kiq back Jane Awesome_Sauce 5555555555554444 50  
Jane backed Awesome_Sauce for $50.  
> kiq list Awesome_Sauce  
Project Name: Awesome_Sauce  
Amount Remaining: $400.0  
BACKERS:  
Backer John, Amount: $50  
Backer Jane, Amount: $50  
> kiq back Mary Awesome_Sauce 5474942730093167 400  
Reached goal!  
Mary backed Awesome_Sauce for $400.  
> kiq list Awesome_Sauce  
Project Name: Awesome_Sauce  
Amount Remaining: $0.0  
Reached goal!  
BACKERS:  
Backer John, Amount: $50  
Backer Jane, Amount: $50  
Backer Mary, Amount: $400  
> kiq backer John  
Backed Awesome_Sauce for $50 dollars.  
```

## Technology/Dependencies

### Why ruby, why a gem (and the downsides to those choices)
* I chose Ruby because I'm the most familiar with it. If I were doing a longer form of this project I may try to build it in Go for better performance. However, for the scope of this project Ruby worked well. 
* I was also interested in Ruby because I thought a gem would work well. I had never build a gem before so it was a fun challenge to tackle.
* I spent most of the planning for this project thinking about whether I should use a gem like [GLI](https://github.com/davetron5000/gli), or build out the whole app myself. I ended up choosing to go without a dependency on another package. I thought deeply about this. Probably too deeply. I weighed ["Not Built Here" Syndrome](http://www.richard-banks.org/2007/07/built-here-syndrome.html) with having to rely on how another person packaged up the CLI app. I ended up siding with less dependencies. I took some tips from the UI in a couple apps, and built out the rest of it myself, which worked well. I watched [Dave Copeland's talk on CLI apps](https://www.youtube.com/watch?v=eYk2Otz4X4I) and while I like Methadone and GLI, I don't particularly like Cucumber, which the built in dependency on Aruba was heavily trying to get me to use. If I were building a bigger project, however, and needed a more stream lined UI, it looks like GLI, Methadone, Highline, and Main are all great gems to use for it.

## Architecture Choices
### Serialization For Storage
I used serialization with a yaml file for storage and made it human-readbale. This helped me not only organize the data but visualize it as it updated. If this project were bigger and had more objects I would want to use a relational database. However, with just two models, Projects and Backers, a hash to handle the Backers worked out well. It also really helped to be able to read the collection of projects from the file. 

### Hash Useage
I employed several hashes for O(1) access. Projects are stored as a hash with the name as the accessor. Backers are stored as a hash with the credit card as the accessor. I know projects weren't required to have unique names, but I built that into the app and it made it easier to assess if a project existed or not. 

## To Do (if only there was more time)
I have a lot of remaining thoughts. A few things that I'd like to work on in the future:
* Make it look prettier, research UI gems like `highline` and `colorize` and look for ways to implement them.
* Refactor the specs. There's a lot of repetition there.
* Add more specs for handling user input.
* Anything! Incorporate an API! Make this an awesome app that you can text to add money to kickstarter campaigns. I was really excited working on this project. 
