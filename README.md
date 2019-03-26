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

To install Arx, run the following in your terminal:

```bash
$ gem install arx
```

## Documentation

The documentation for Arx is hosted on [![rubydoc.info](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://www.rubydoc.info/gems/arx/toplevel).

## Usage

Before you start using Arx, you'll have to ensure that the gem is required (either in your current working file, or shell such as [IRB](https://en.wikipedia.org/wiki/Interactive_Ruby_Shell)):

```ruby
require 'arx'
```

### Building search queries

Query requests submitted to the arXiv search API are typically of the following form (where the query string is indicated in bold):

[http://export.arxiv.org/api/query?**search_query=ti:%22Buchi+Automata%22+AND+cat:%22cs.FL%22**](http://export.arxiv.org/api/query?search_query=ti:%22Buchi+Automata%22+AND+cat:%22cs.FL%22)

> This particular query searches for papers whose title includes the string `Buchi Automata`, and are in the *Formal Languages and Automata Theory* (`cs.FL`) category.

Obviously writing out queries like this can quickly become time-consuming and tedious.

---

The `Arx::Query` class provides a small embedded DSL for writing these query strings.

#### Sorting criteria and order

The order in which search results are returned can be modified through the `sort_by` and `sort_order` keyword arguments (in the `Arx::Query` initializer):

- `sort_by` accepts the symbols: `:relevance`, `:last_updated` or `:date_submitted` 

- `sort_order` accepts the symbols: `:ascending` or `:descending`

```ruby
# Sort by submission date in ascending order (earliest first)
Arx::Query.new(sort_by: :date_submitted, sort_order: :ascending) 
#=> sortBy=submittedDate&sortOrder=ascending
```

**Note**: The default setting is to sort by `:relevance` in `:descending` order:

```ruby
Arx::Query.new #=> sortBy=relevance&sortOrder=descending
```

#### Searching by ID

The arXiv search API doesn't only support searching for papers by metadata fields, but also by ID. When searching by ID, a different URL query string parameter `id_list` is used (instead of `search_query` as seen before). 

Although the `id_list` can be used to *"search by ID"*, it is better to **think of it as restricting the search space to the papers with the provided IDs**:

| `search_query` present? | `id_list` present? | Returns                                              |
| ----------------------- | ------------------ | ---------------------------------------------------- |
| Yes                     | No                 | Articles that match `search_query`                   |
| No                      | Yes                | Articles that are in `id_list`                       |
| Yes                     | Yes                | Articles in `id_list` that also match `search_query` |

To search by ID, simply pass the arXiv paper identifiers (ID) or URLs into the `Arx::Query` initializer method:

```ruby
Arx::Query.new('https://arxiv.org/abs/1711.05738', '1809.09415')
#=> sortBy=relevance&sortOrder=descending&id_list=1711.05738,1809.09415
```

#### Searching by metadata fields

The arXiv search API supports searches for the following paper metadata fields:

```ruby
FIELDS = {
  title: 'ti',     # Title
  author: 'au',    # Author
  abstract: 'abs', # Abstract
  comment: 'co',   # Comment
  journal: 'jr',   # Journal reference
  category: 'cat', # Subject category
  report: 'rn',    # Report number
  all: 'all'       # All (of the above)
}
```

Each of these fields has an instance method defined under the `Arx::Query` class. For example:

```ruby
# Papers whose title contains the string "Buchi Automata".
q = Arx::Query.new
q.title('Buchi Automata')
#=> sortBy=relevance&sortOrder=descending&search_query=ti:%22Buchi+Automata%22
```

##### Exact matches

By default, this searches for exact matches of the provided string (by adding double quotes around the string - in the query string, this is represented by the `%22`s). To disable this, you can use the `exact` keyword argument (which defaults to `true`):

```ruby
# Papers whose title contains either the words "Buchi" or "Automata".
q = Arx::Query.new
q.title('Buchi Automata', exact: false)
#=> sortBy=relevance&sortOrder=descending&search_query=ti:Buchi+Automata
```

##### Multiple values for one field

Sometimes you might want to provide multiple field values to search for a paper by. This can simply be done by adding them as another argument (or providing an `Array`):

**Note**: The default logical connective used when there are multiple values for one field is `and`.

```ruby
# Papers authored by both "Eleonora Andreotti" and "Dominik Edelmann".
q = Arx::Query.new
q.author('Eleonora Andreotti', 'Dominik Edelmann')
```

To change the logical connective to `or` or `not` (and not), use the `connective` keyword argument:

```ruby
# Papers authored by either "Eleonora Andreotti" or "Dominik Edelmann".
q = Arx::Query.new
q.author('Eleonora Andreotti', 'Dominik Edelmann', connective: :or)
```

```ruby
# Papers authored by "Eleonora Andreotti" and not "Dominik Edelmann".
q = Arx::Query.new
q.author('Eleonora Andreotti', 'Dominik Edelmann', connective: :and_not)
```

#### Chaining subqueries (logical connectives)

**Note**: By default, subqueries (successive instance method calls) are chained with a logical `and` connective.

```ruby
# Papers authored by "Dominik Edelmann" in the "Numerical Analysis" (math.NA) category.
q = Arx::Query.new
q.author('Dominik Edelmann')
q.category('math.NA')
```

To change the logical connective used to chain subqueries, use the `&()` (and), `|()` (or) and `!()` (and not) instance methods between the subquery calls:

```ruby
# Papers authored by "Eleonora Andreotti" in neither the "Numerical Analysis" (math.NA) or "Combinatorics (math.CO)" categories.
q = Arx::Query.new
q.author('Eleonora Andreotti')
q.!()
q.category('math.NA', 'math.CO', connective: :or)
```

### Running search queries

### Query results and entities