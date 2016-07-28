
Minikiq [![Build Status](https://travis-ci.org/loganmeetsworld/minikiq.svg?branch=master)](https://travis-ci.org/loganmeetsworld/minikiq) [![Gem Version](https://badge.fury.io/rb/minikiq.svg)](https://badge.fury.io/rb/minikiq) [![Inline docs](http://inch-ci.org/github/loganmeetsworld/minikiq.svg?branch=master)](http://inch-ci.org/github/loganmeetsworld/minikiq) [![Code Climate](https://codeclimate.com/github/loganmeetsworld/minikiq/badges/gpa.svg)](https://codeclimate.com/github/loganmeetsworld/minikiq)
=========

## Summary
Minikiq is a crowd funding application that can be run from your command line. This project was a learning experience. Key learning points for me were:
* Building a Ruby gem.
* Struggling with deciding if I should use other gems and build in dependencies.
* Testing Ruby and making code more modular.
* Getting over my Rails addiction to lovely built in libraries and methods.

## Installation
This is a Ruby Gem! It can be found on the rubygems site [here](https://rubygems.org/gems/minikiq) and easily implemented on any operating system that has Ruby installed with the command `gem install minikiq`.  

I tested this gem out on OSX El Capitan, Yosemite, Microsoft 10, and Linux. Just make sure you have [https://www.ruby-lang.org/en/documentation/installation/](Ruby installed on your OS). RubyGems comes with a Ruby installation.  

This gem uses serialization to store the projects in a `.minikiq` yml file. If you don't want this file in whatever folder you are currently in, I would suggest creating a new folder to use the gem:  
`cd projects`  
`mkdir minikiq`  
`gem install minikiq`  
And then you're off! If you ever want to remove the `.minikiq` yaml file, delete it from the folder with:  
`rm .minikiq`  

If you're interesting in developing with the code, use git to clone this repo:  
`git clone https://github.com/loganmeetsworld/minikiq.git`

## Sample Input and Output
```
> minikiq project Awesome_Sauce 500  
Added Project: Awesome_Sauce!  
> minikiq back John Awesome_Sauce 4111111111111111 50  
John backed Awesome_Sauce for $50.  
> minikiq back Sally Awesome_Sauce 1234567890123456 10  
ERROR: That card fails Luhn-10!  
> minikiq back Jane Awesome_Sauce 4111111111111111 50  
ERROR: That card has already been added by another user!  
> minikiq back Jane Awesome_Sauce 5555555555554444 50  
Jane backed Awesome_Sauce for $50.  
> minikiq list Awesome_Sauce  
Project Name: Awesome_Sauce  
Amount Remaining: $400.0  
BACKERS:  
Backer John, Amount: $50  
Backer Jane, Amount: $50  
> minikiq back Mary Awesome_Sauce 5474942730093167 400  
Reached goal!  
Mary backed Awesome_Sauce for $400.  
> minikiq list Awesome_Sauce  
Project Name: Awesome_Sauce  
Amount Remaining: $0.0  
Reached goal!  
BACKERS:  
Backer John, Amount: $50  
Backer Jane, Amount: $50  
Backer Mary, Amount: $400  
> minikiq backer John  
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
