# Arx

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/ArXiv_web.svg/1200px-ArXiv_web.svg.png" width="15%" align="right"></img>

[![Ruby Version](https://img.shields.io/badge/ruby-~%3E%202.5-red.svg)](https://github.com/eonu/arx/blob/503a1c95ac450dbc20623491060c3fc32d213627/arx.gemspec#L19)
[![Gem](https://img.shields.io/gem/v/arx.svg)](https://rubygems.org/gems/arx)
[![License](https://img.shields.io/github/license/eonu/arx.svg)](https://github.com/eonu/arx/blob/master/LICENSE)

[![Maintainability](https://api.codeclimate.com/v1/badges/e94073dfa8c3e2442298/maintainability)](https://codeclimate.com/github/eonu/arx/maintainability)
[![Build Status](https://travis-ci.com/eonu/arx.svg?branch=master)](https://travis-ci.com/eonu/arx)
[![Coverage Status](https://coveralls.io/repos/github/eonu/arx/badge.svg?branch=feature%2Fcoveralls)](https://coveralls.io/github/eonu/arx?branch=feature%2Fcoveralls)

**A Ruby interface for querying academic papers on the arXiv search API.**

<img src="https://i.ibb.co/19Djpzk/arxiv.png" width="25%" align="left"></img>

> arXiv is an e-print service in the fields of physics, mathematics, non-linear science, computer science, quantitative biology, quantitative finance and statistics.

---

[arXiv](https://arxiv.org/) provides an advanced search utility (shown left) on their website, as well as an extensive [search API](https://arxiv.org/help/api) that allows for the external querying of academic papers hosted on their website.

Although [Scholastica](https://github.com/scholastica) offer a great [Ruby gem](https://github.com/scholastica/arxiv) for retrieving papers from arXiv through the search API, this gem is only intended for retrieving one paper at a time, and only supports searching for paper by ID.

*Arx is a gem that allows for quick and easy querying of the arXiv search API, without having to worry about manually writing your own search query strings or parse the resulting XML query response to find the data you need.*

## Example

Suppose we wish to search for:

> Papers in the `cs.FL` (Formal Languages and Automata Theory) category whose title contains `"Buchi Automata"`, not authored by `Tomáš Babiak`, sorted by submission date (latest first).

This query can be executed with the following code:

```ruby
require 'arx'

papers = Arx(sort_by: :date_submitted) do |query|
  query.category('cs.FL')
  query.title('Buchi Automata').and_not.author('Tomáš Babiak')
end
```

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

The documentation for Arx is hosted on [![rubydoc.info](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://www.rubydoc.info/github/eonu/arx/master/toplevel).

## Contributing

All contributions to Arx are greatly appreciated. Contribution guidelines can be found [here](/CONTRIBUTING.md).

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

To change the logical connective used to chain subqueries, use the `and`, `or`, `and_not` instance methods between the subquery calls:

```ruby
# Papers authored by "Eleonora Andreotti" in neither the "Numerical Analysis" (math.NA) or "Combinatorics (math.CO)" categories.
q = Arx::Query.new
q.author('Eleonora Andreotti')
q.and_not
q.category('math.NA', 'math.CO', connective: :or)
```

#### Grouping subqueries

Sometimes you'll have a query that requires nested or grouped logic, with parentheses. This can be done using the `Arx::Query#group` method.

This method accepts a block, and basically parenthesises the result of whichever methods were called in the block.

For example, this will allow the last query from the previous section to be written as:

```ruby
# Papers authored by "Eleonora Andreotti" in neither the "Numerical Analysis" (math.NA) or "Combinatorics (math.CO)" categories.
q = Arx::Query.new
q.author('Eleonora Andreotti')
q.and_not
q.group do
  q.category('math.NA').or.category('math.CO')
end
```

Another more complicated example with two grouped subqueries:

```ruby
# Papers whose title contains "Buchi Automata", either authored by "Tomáš Babiak", or in the "Formal Languages and Automata Theory (cs.FL)" category and not the "Computational Complexity (cs.CC)" category.
q = Arx::Query.new
q.title('Buchi Automata')
q.group do
  q.author('Tomáš Babiak')
  q.or
  q.group do
    q.category('cs.FL').and_not.category('cs.CC')
  end
end
```

### Running search queries

Search queries can be executed with the `Arx()` method (alias of `Arx.search`). This method contains the same parameters as the `Arx::Query` initializer - including the list of IDs.

#### Without a predefined query

Calling the `Arx()` method with a block allows for the construction and execution of a new query.

**Note**: If running a search query this way, then the `sort_by` and `sort_order` parameters can be added as additional keyword arguments.

```ruby
# Papers in the cs.FL category whose title contains "Buchi Automata", not authored by Tomáš Babiak
results = Arx(sort_by: :date_submitted) do |query|
  query.category('cs.FL')
  query.title('Buchi Automata').and_not.author('Tomáš Babiak')
end

results.size #=> 18
```

#### With a predefined query

The `Arx()` method accepts a predefined `Arx::Query` object through the `query` keyword parameter.

**Note**: If using the `query` parameter, the `sort_by` and `sort_order` criteria should be defined in the `Arx::Query` object initializer rather than as arguments in `Arx()`.

```ruby
# Papers in the cs.FL category whose title contains "Buchi Automata", not authored by Tomáš Babiak
q = Arx::Query.new(sort_by: :date_submitted)
q.category('cs.FL')
q.title('Buchi Automata').and_not.author('Tomáš Babiak')

results = Arx(query: q)
results.size #=> 18
```

#### With IDs

The `Arx()` methods accepts a list of IDs as a splat parameter, just like the `Arx::Query` initializer.

If only one ID is specified, then a single `Arx::Paper` is returned:

```ruby
result = Arx('1809.09415')
result.class #=> Arx::Paper
```

Otherwise, an `Array` of `Arx::Paper`s is returned.

### Query results

Search results are typically:

- an `Array`, either empty if no papers matched the supplied query, or containing `Arx::Paper` objects.
- a single `Arx::Paper` object (when the search method is only supplied with one ID).

### Entities

The `Arx::Paper`, `Arx::Author` and `Arx::Category` classes provide a simple interface for the metadata concerning a single arXiv paper:

#### `Arx::Paper`

```ruby
paper = Arx('1809.09415')
#=> #<Arx::Paper:0x00007fb657b59bd0>

paper.id
#=> "1809.09415"
paper.id(version: true)
#=> "1809.09415v1"
paper.url
#=> "http://arxiv.org/abs/1809.09415"
paper.url(version: true)
#=> "http://arxiv.org/abs/1809.09415v1"
paper.version
#=> 1
paper.revision?
#=> false

paper.title
#=> "On finitely ambiguous Büchi automata"
paper.summary
#=> "Unambiguous B\\\"uchi automata, i.e. B\\\"uchi automata allowing..."
paper.authors
#=> [#<Arx::Author:0x00007fb657b63108>, #<Arx::Author:0x00007fb657b62438>]

# Paper's categories
paper.primary_category
#=> #<Arx::Category:0x00007fb657b61830>
paper.categories
#=> [#<Arx::Category:0x00007fb657b60e80>]

# Dates
paper.published_at
#=> #<DateTime: 2018-09-25T11:40:39+00:00 ((2458387j,42039s,0n),+0s,2299161j)>
paper.updated_at
#=> #<DateTime: 2018-09-25T11:40:39+00:00 ((2458387j,42039s,0n),+0s,2299161j)>

# Paper's comment
paper.comment?
#=> false
paper.comment
#=> Arx::Error::MissingField (arXiv paper 1809.09415 is missing the `comment` metadata field)

# Paper's journal reference
paper.journal?
#=> false
paper.journal
#=> Arx::Error::MissingField (arXiv paper 1809.09415 is missing the `journal` metadata field)

# Paper's PDF URL
paper.pdf?
#=> true
paper.pdf_url
#=> "http://arxiv.org/pdf/1809.09415v1"

# Paper's DOI (Digital Object Identifier) URL
paper.doi?
#=> true
paper.doi_url
#=> "http://dx.doi.org/10.1007/978-3-319-98654-8_41"
```

#### `Arx::Author`

```ruby
paper = Arx('cond-mat/9609089')
#=> #<Arx::Paper:0x00007fb657a7b8d0>

author = paper.authors.first
#=> #<Arx::Author:0x00007fb657a735e0>

author.name
#=> "F. Gebhard"

author.affiliated?
#=> true
author.affiliations
#=> ["ILL Grenoble, France"]
```

#### `Arx::Category`

```ruby
paper = Arx('cond-mat/9609089')
#=> #<Arx::Paper:0x00007fb657b59bd0>

category = paper.primary_category
#=> #<Arx::Category:0x00007fb6570609b8>

category.name
#=> "cond-mat"
category.full_name
#=> "Condensed Matter"
```

# Thanks

A large portion of this library is based on the brilliant work done by [Scholastica](https://github.com/scholastica) in their [`arxiv`](https://github.com/scholastica/arxiv) gem for retrieving individual papers from arXiv through the search API.

Arx was created mostly due to the seemingly inactive nature of Scholastica's repository. Additionally, it would have been infeasible to contribute such large changes to an already well-established gem, especially since https://scholasticahq.com/ appears to be dependent upon this gem.

---

Nevertheless, a special thanks goes out to Scholastica for providing the influence for Arx.