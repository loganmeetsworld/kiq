
Kiq [![Build Status](https://travis-ci.org/loganmeetsworld/kiq.svg?branch=master)](https://travis-ci.org/loganmeetsworld/kiq) [![Gem Version](https://badge.fury.io/rb/kiq.svg)](https://badge.fury.io/rb/kiq) [![Inline docs](http://inch-ci.org/github/loganmeetsworld/kiq.svg?branch=master)](http://inch-ci.org/github/loganmeetsworld/kiq) [![Code Climate](https://codeclimate.com/github/loganmeetsworld/kiq/badges/gpa.svg)](https://codeclimate.com/github/loganmeetsworld/kiq)
=========

## Summary
kiq is a crowd funding application that can be run from your command line. This project was a learning experience. Key learning points for me were:
* Building a Ruby gem.
* Struggling with deciding if I should use other gems and build in dependencies.
* Testing Ruby and making code more modular.
* Getting over my Rails addiction to lovely built in libraries and methods.

## Installation
This is a Ruby Gem (Yeah, it's crazy to me that I got this namespacing as well)! It can be found on the rubygems site [here](https://rubygems.org/gems/kiq) and easily implemented on any operating system that has Ruby installed with the command `gem install kiq`.  

I tested this gem out on OSX El Capitan, Yosemite, Microsoft 10, and Linux. Just make sure you have [https://www.ruby-lang.org/en/documentation/installation/](Ruby installed on your OS). RubyGems comes with a Ruby installation.  

This gem uses serialization to store the projects in a `.kiq` yml file. If you don't want this file in whatever folder you are currently in, I would suggest creating a new folder to use the gem:  
`cd projects`  
`mkdir kiq`  
`gem install kiq`  
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
### Let's talk about assumptions
* I want to recognize that I made a couple of assumptions in this process. The first assumption was that a user downloading the gem was using a Mac. 

### Why ruby, why a gem (and the downsides to those choices)
### To depend, or not to depend? That is the question.
### Serialization For Storage
### Hash Useage

## To Do (if only there was more time)
A lot of things.
* Make it look prettier, research UI gems like `highline` and `colorize` and look for ways to implement them.
* Refactor the specs. There's a lot of repetition there.
* Add specs for handling user input.
