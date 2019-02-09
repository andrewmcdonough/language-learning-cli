# Command Line Language Learning

## Background

I've been learning German using a number of different tools and techniques. I've tried a number of language learning apps like Duolingo. I like them, but there are a few features I wanted that I couldn't find in other apps, so I decided to build my own set of tools. These are for personal use, and are very immature, so not really currently meant for others.

## Goals of the tools

* Must primarily work on the command line
* Must be able to easily update my own word lists

## How it works

Store personal wordlists are in /lists/{from language}-{to language}. Entries in these files are word pairs separated by a hypen, e.g.

```
danke - thank you
```

The only word list available so far is my personal German-English list.

## Requirements

* Ruby
* Bundler
* OSX (for speech output)

## Installation instructions

* Clone the repo
* Install the gems:
```
bundle install
```

## Running study mode

```
bundle exec study.rb
```

## Running tests

```
bundle exec rake
```

## Next steps

* Extract outputs (text display and text-to-speech)
* Implement learning mode, generating sound files to listen to
* Keep track of performance and implement spaced repetition
