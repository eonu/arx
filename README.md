# Arx

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/ArXiv_web.svg/1200px-ArXiv_web.svg.png" width="15%" align="right"></img>

[![Ruby Version](https://img.shields.io/badge/ruby-~%3E%202.5-red.svg)](https://github.com/eonu/arx/blob/503a1c95ac450dbc20623491060c3fc32d213627/arx.gemspec#L19)
[![Gem](https://img.shields.io/gem/v/arx.svg)](https://rubygems.org/gems/arx)
[![License](https://img.shields.io/github/license/eonu/arx.svg)](https://github.com/eonu/arx/blob/master/LICENSE)

[![Maintainability](https://api.codeclimate.com/v1/badges/e94073dfa8c3e2442298/maintainability)](https://codeclimate.com/github/eonu/arx/maintainability)
[![Documentation](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://www.rubydoc.info/gems/arx/toplevel)
[![Build Status](https://travis-ci.com/eonu/arx.svg?branch=master)](https://travis-ci.com/eonu/arx)

**A Ruby interface for querying academic papers on the arXiv search API.**

<img src="https://i.ibb.co/19Djpzk/arxiv.png" width="25%" align="left"></img>

> arXiv is an e-print service in the fields of physics, mathematics, non-linear science, computer science, quantitative biology, quantitative finance and statistics.

---

[arXiv](https://arxiv.org/) provides an advanced search utility (shown left) on their website, as well as an extensive [search API](https://arxiv.org/help/api) that allows for the external querying of academic papers hosted on their website.

Although [Scholastica](https://github.com/scholastica) offer a great [Ruby gem](https://github.com/scholastica/arxiv) for retrieving papers from arXiv through the search API, this gem is only intended for retrieving one paper at a time, and only supports searching for paper by ID.

*Arx is a gem that allows for quick and easy querying of the arXiv search API, without having to worry about manually writing your own search query strings or parse the resulting XML query response to find the data you need.*

## Features

- Ruby classes `Arx::Paper`, `Arx::Author` and `Arx::Category` that wrap the resulting Atom XML query result from the search API.
- Supports querying by a paper's ID, title, author(s), abstract, subject category, comment, journal reference, or report number.
- Provides a small embedded DSL for writing queries.
- Supports searching fields by exact match.

## Installation

To install the gem, run:

```bash
$ gem install arx
```

## Documentation

The documentation for Arx is hosted on [![Documentation](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://www.rubydoc.info/gems/arx/toplevel).

## Usage

Before you start using `arx`, you'll have to ensure that the gem is required (either in your current working file, or shell such as [IRB](https://en.wikipedia.org/wiki/Interactive_Ruby_Shell)):

```ruby
require 'arx'
```

### Building search queries

### Query results and entities