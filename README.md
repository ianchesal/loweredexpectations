# lowered-expectations

[![Gem Version](https://badge.fury.io/rb/lowered-expectations.svg)](http://badge.fury.io/rb/lowered-expectations)

[![Build Status](https://travis-ci.org/ianchesal/loweredexpectations.svg?branch=master)](https://travis-ci.org/ianchesal/loweredexpectations)

A Ruby gem that lets you test for the presence of command line tools and ensure
that you have a version of the tool that you know how to work with.

It uses the gem system's version matching semantics so you can do things like
enforce a major version but allow any minor version above a certain value for a
tool. If you use Gemfile's the syntax should look pretty familiary to you.

## Installation

    gem install lowered-expectations

## Use

    require 'lowered/expectations'
    LoweredExpectations.expect('curl', "~> 7.0")
    # If I get to here I know I have a version of curl I can use

The following errors can be raised when using this Gem:

* `LoweredExpectations::VersionPatternError` - Raised if the version pattern supplied isn't recognized
* `LoweredExpectations::IncompatibleVersionError` - Raised if the version of the tool does not match the expected version pattern
* `LoweredExpectations::MissingExecutableError` - Raised if the tool cannot be found on your `PATH`

## Development

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/loweredexpectations/

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `packer-config`? Hit me up at ian.chesal@gmail.com or ianc@squareup.com.
