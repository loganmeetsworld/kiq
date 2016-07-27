
Minikiq [![Build Status](https://travis-ci.org/loganmeetsworld/minikiq.svg?branch=master)](https://travis-ci.org/loganmeetsworld/minikiq) [![Gem Version](https://badge.fury.io/rb/minikiq.svg)](https://badge.fury.io/rb/minikiq)
=========

## Summary

## Installation
This is a Ruby Gem! It can be found on the rubygems site [here](https://rubygems.org/gems/minikiq). This gem uses serialization to store the projects you currently have in a `.minikiq` yml file. If you don't want this file in whatever folder you are currently in, I would suggest creating a new folder to use the gem:
`cd projects`
`mkdir minikiq`
`gem install minikiq`
And then you're off!

## Sample Input and Output

Input: `minikiq project Awesome_Sauce 500`
Output: `Added Project: Awesome_Sauce!`
Input: `minikiq back John Awesome_Sauce 4111111111111111 50`
Output: `John backed Awesome_Sauce for $50.`
Input: `minikiq back Sally Awesome_Sauce 1234567890123456 10`
Output: `ERROR: That card fails Luhn-10!`
Input: `minikiq back Jane Awesome_Sauce 4111111111111111 50`
Output: `ERROR: That card has already been added by another user!`
Input: `minikiq back Jane Awesome_Sauce 5555555555554444 50`
Output: `Jane backed Awesome_Sauce for $50.`
Input: `minikiq list Awesome_Sauce`
Output: `Project Name: Awesome_Sauce
Amount Remaining: $400.0
BACKERS:
Backer John, Amount: $50
Backer Jane, Amount: $50`
Input: `minikiq back Mary Awesome_Sauce 5474942730093167 400`
Output: `Reached goal!
Mary backed Awesome_Sauce for $400.`
Input: `minikiq list Awesome_Sauce`
Output: `Project Name: Awesome_Sauce
Amount Remaining: $0.0
Reached goal!
BACKERS:
Backer John, Amount: $50
Backer Jane, Amount: $50
Backer Mary, Amount: $400`
Input: `minikiq backer John`
Output: `Backed Awesome_Sauce for $50 dollars.`

## Technology/Dependencies
### Why ruby, why a gem (and the downsides to those choices)
### To depend, or not to depend? That is the question.
### Serialization data storage

## To Do (if only there was more time)
A lot of things.
* Make it look better
* 
