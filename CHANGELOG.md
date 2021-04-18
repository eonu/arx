## 1.2.2

### Major changes

- Add support for paging. ([#92](https://github.com/eonu/arx/pull/92) by @xuanxu)
- Allow searching by `last_updated_date`. ([#93](https://github.com/eonu/arx/pull/93) by @xuanxu)
- Add `submitted_at` for submission date querying. ([#97](https://github.com/eonu/arx/pull/97))<br/>
  This also changes `last_updated_date` from #93 to `updated_at`, and similarly for the `last_updated` and `date_submitted` [sort-by criteria](https://github.com/eonu/arx/blob/3d093658579fb2d99b92f0feedb2aa790a22e2c8/lib/arx/query/query.rb#L43).

### Minor changes

- Update `Arx()` to match new `Arx.search` signature (from #92). ([#94](https://github.com/eonu/arx/pull/94))
- Change incorrect `lastUpdated` sort-by criterion to `lastUpdatedDate`. ([#96](https://github.com/eonu/arx/pull/96))
- Add `to_s` methods for `Arx::Paper`, `Arx::Author` and `Arx::Category`. ([#99](https://github.com/eonu/arx/pull/99))
- Add fix for JSON warning in Ruby >=2.7. ([#101](https://github.com/eonu/arx/pull/101))
- Add contributors section to `README.md`. ([#102](https://github.com/eonu/arx/pull/102))

## 1.2.1

### Major changes

- Add support for saving PDFs with `Paper#save` (see #81). ([#90](https://github.com/eonu/arx/pull/90))
- Change gem Ruby version specifier from `~> 2.5` to `>= 2.5`. ([#86](https://github.com/eonu/arx/pull/86))

### Minor changes

- Remove arXiv logo from `README.md`. ([#87](https://github.com/eonu/arx/pull/87))
- Use `URI.open` instead of `Kernel.open` (see #82). ([#86](https://github.com/eonu/arx/pull/86))
- Add CI rubies `2.7` and `3.0` (see #84). ([#86](https://github.com/eonu/arx/pull/86))
- Remove unnecessary arXiv information from `README.md` (see #83). ([#86](https://github.com/eonu/arx/pull/86))
- Remove system gem update directive in `.travis.yml`. ([#78](https://github.com/eonu/arx/pull/78))
- Remove version specifier for `bundler` gem in `arx.gemspec`. ([#77](https://github.com/eonu/arx/pull/77))
- Update specs using paper `1710.02185` to account for revision and acceptance by journal (_congratulations!_). ([#76](https://github.com/eonu/arx/pull/76))
- Update email address in `LICENSE.md`. ([#73](https://github.com/eonu/arx/pull/73))

## 1.2.0

### Major changes

- Adds serialization support through the following methods ([#63](https://github.com/eonu/arx/pull/63)):
  - `to_h`: Serialize into a Ruby hash (with symbol keys). Accepts a boolean argument, representing whether or not to deep-serialize nested `Author` and `Category` objects (defaults to `false`).
  - `as_json`: Serialize into a Ruby hash which is also a valid JSON hash.
  - `to_json`: Serialize into a valid JSON string.
- Remove version filter from query ID list. ([#69](https://github.com/eonu/arx/pull/69))
  > Previously, all of the following would return the latest paper, `1807.06918v2`:
  > ```ruby
  > Arx.get('1807.06918').version #=> 2
  > Arx.get('1807.06918v1').version #=> 2
  > Arx.get('1807.06918v2').version #=> 2
  > ```

- Adds `ATTRIBUTES` constant for `Paper`, `Author` and `Category` entities, as a list of which attributes are available for the entity. ([#63](https://github.com/eonu/arx/pull/63))
- Remove key-word arguments from `Paper#id` and `Paper#url`. ([#70](https://github.com/eonu/arx/pull/70))
  > Previously, `Paper#id` and `Paper#url` accepted a `version` key-word argument, which was a boolean variable indicating whether or not to include the version number in the ID or URL.
  >
  > This has now been changed to a regular argument, which still defaults to `false`.
  > ```ruby
  > paper = Arx.get('cond-mat/9609089')
  >
  > # Old (no longer works)
  > paper.id(version: true)
  > paper.url(version: true)
  >
  > # New
  > paper.id(true) #=> "cond-mat/9609089v1"
  > paper.url(true) #=> "http://arxiv.org/abs/cond-mat/9609089v1"
  > ```

- Add equality operator (`==`) to entities. ([#68](https://github.com/eonu/arx/pull/68))

### Minor changes

- Add more category mappings to `CATEGORIES`. ([#71](https://github.com/eonu/arx/pull/71))
- Add licensing information to `README.md` under the *Acknowledgements* section. ([#66](https://github.com/eonu/arx/pull/66))
- Add `yard` development dependency for documentation. ([#65](https://github.com/eonu/arx/pull/65))
- Make documentation spacing uniform. ([#64](https://github.com/eonu/arx/pull/64))
- Coveralls:
  - `coveralls` [`= 0.8.22` to `= 0.8.23`] ([#62](https://github.com/eonu/arx/pull/62))
  - `thor` [`~> 0.19.4` to `~> 0.20.3`] ([#67](https://github.com/eonu/arx/pull/67))

## 1.1.0

### Major changes

- Change `bundler` requirement to `>= 1.17` in `arx.gemspec`. ([#53](https://github.com/eonu/arx/pull/53))
- Remove `Arx.find` alias of `Arx.search`. ([#57](https://github.com/eonu/arx/pull/57))
- Add `Query#group` for subquery grouping support. ([#59](https://github.com/eonu/arx/pull/59))

### Minor changes

- Add contributing guidelines (`CONTRIBUTING.md`). ([#48](https://github.com/eonu/arx/pull/48))
- Add issue templates to `./github/ISSUE_TEMPLATE` for ([#49](https://github.com/eonu/arx/pull/49), [#54](https://github.com/eonu/arx/pull/54), [#55](https://github.com/eonu/arx/pull/55)):
  - **Error or warning**<br>For reporting an error or warning generated by Arx.
  - **Unexpected or incorrect functionality**<br>For reporting something that doesn't seem to be working correctly or is unexpected.
  - **Improvement to an existing feature**<br>For suggesting an improvement to a feature already offered by Arx.
  - **Suggesting a new feature**<br>For proposing a new feature to Arx that would be beneficial.
- Add a pull request template at `./github/PULL_REQUEST_TEMPLATE.md`. ([#49](https://github.com/eonu/arx/pull/49))
- Remove issue templates from `CONTRIBUTING.md`. ([#49](https://github.com/eonu/arx/pull/49))
- Remove `LICENSE` from YARD documentation (remove from `.yardopts`). ([#50](https://github.com/eonu/arx/pull/50))
- Add RVM ruby version `2.6` to `.travis.yml`. ([#53](https://github.com/eonu/arx/pull/53))
- Add contributor code-of-conduct (`CODE_OF_CONDUCT.md`). ([#56](https://github.com/eonu/arx/pull/56))
- Thank Scholastica in `README.md`. ([#58](https://github.com/eonu/arx/pull/58))
- Add `bin/console` for gem debugging. ([#60](https://github.com/eonu/arx/pull/60))
- Modify `gem:debug` rake task to run `bin/console`. ([#60](https://github.com/eonu/arx/pull/60))

## 1.0.1

### Major changes

- Add cases to handle `nil` query returns. ([#45](https://github.com/eonu/arx/pull/45))
- Add support for the `coveralls` gem (`.coveralls.yml` configuration file). ([#42](https://github.com/eonu/arx/pull/42))

### Minor changes

- Add code coverage badge to `README.md`. ([#42](https://github.com/eonu/arx/pull/42))
- Remove documentation badge from top of `README.md`. ([#42](https://github.com/eonu/arx/pull/42))
- Change author email from `ed@mail.eonu.net` to `ed@eonu.net`. ([#43](https://github.com/eonu/arx/pull/43))
- Change `ends_with_connective?` to `end_with_connective?` to follow typical Ruby patterns. ([#44](https://github.com/eonu/arx/pull/44))
- Add `/coverage/` directory to `.gitignore`. ([#45](https://github.com/eonu/arx/pull/45))
- Remove version numbers from paper identifiers in error message in `README.md`. ([#46](https://github.com/eonu/arx/pull/46))

## 1.0.0

### Major changes

- Change `Query` connective instance methods ([#38](https://github.com/eonu/arx/pull/38)):
  - `#&` -> `#and`
  - `#|` -> `#or`
  - `#!` -> `#and_not`
- Split version number from paper identifier in `Paper` (add `version` key-word argument to `#id` and `#url`, and add `#version`). ([#39](https://github.com/eonu/arx/pull/39))
- Add `Cleaner.extract_id` and `Cleaner.extract_version`. ([#39](https://github.com/eonu/arx/pull/39))
- Make `Query#add_connective` always return `self`. ([#40](https://github.com/eonu/arx/pull/40))
- Redefine `Arx.search` to user `Paper.parse`'s `search` key-word argument. ([#40](https://github.com/eonu/arx/pull/40))
- Implement all tests. ([#40](https://github.com/eonu/arx/pull/40))

### Minor changes

- Change declared regular expression literals from `%r""` to standard `//`. ([#39](https://github.com/eonu/arx/pull/39))
- Remove `#extract_id` from `Query` and use `Cleaner.extract_id` instead. ([#39](https://github.com/eonu/arx/pull/39))
- Redefine `Paper#revision?` to use the new `#version` instead of `#updated_at` and`#published_at`. ([#39](https://github.com/eonu/arx/pull/39))

## 0.3.2

### Major changes

- Add `Paper#category` alias for `Paper#primary_category`. ([#34](https://github.com/eonu/arx/pull/34))
- Change `Author#affiliations?` to `Author#affiliated?`. ([#34](https://github.com/eonu/arx/pull/34))
- Change `Paper#last_updated` to `Paper#updated_at` (and remove `updated_at` alias). ([#34](https://github.com/eonu/arx/pull/34))
- Change `Paper#publish_date` to `Paper#published_at` (and remove `published_at` alias). ([#34](https://github.com/eonu/arx/pull/34))
- Conditionally assign query object in `Arx.search` with `||=` operator. ([#33](https://github.com/eonu/arx/pull/33))
- Add `gem:debug` rake task for loading the gem into an interactive console. ([#28](https://github.com/eonu/arx/pull/28))
- Add `gem:release` rake task for preparing gem releases. ([#36](https://github.com/eonu/arx/pull/36))
- Add `thor` gem development dependency. ([#36](https://github.com/eonu/arx/pull/36))

### Minor changes

- Update documentation links to `rubydoc.info`'s GitHub service. ([#30](https://github.com/eonu/arx/pull/30))
- Add email address to `LICENSE`. ([#31](https://github.com/eonu/arx/pull/31))
- Improve `Error::MissingField` and `Error::MissingLink` error messages. ([#35](https://github.com/eonu/arx/pull/35))

## 0.3.1

### Major changes

- Add `.yardopts` for document generation configuration. ([#26](https://github.com/eonu/arx/pull/26))
- Namespace errors in `Arx::Error` module and remove `Error` prefix from error classes. ([#26](https://github.com/eonu/arx/pull/26))
- Move identifier format regular expression constant definitions from `Arx::Validate` to top-level namespace `Arx`. ([#26](https://github.com/eonu/arx/pull/26))

### Minor changes

- Rename `lib/arx/exceptions.rb` to `lib/arx/errors.rb`. ([#26](https://github.com/eonu/arx/pull/26))
- Make `Arx::Cleaner`, `Arx::Validate`, `Arx::Inspector`, `Arx::Link` private (hidden from `yard` documentation). ([#26](https://github.com/eonu/arx/pull/26))

## 0.3.0

### Major changes

- Add documentation, images, installation and usage instructions to `README.md`. ([#22](https://github.com/eonu/arx/pull/22), [#17](https://github.com/eonu/arx/pull/17))
- Allow prior construction of a search query in `Arx.search`. ([#18](https://github.com/eonu/arx/pull/18))
- Fix `Arx.search` query object yielding. ([#20](https://github.com/eonu/arx/pull/20))

### Minor changes

- Remove conditional with `block_given?` in `Arx()` method. ([#16](https://github.com/eonu/arx/pull/16))
- Remove leading ampersand (&) from search query string. ([#19](https://github.com/eonu/arx/pull/19))
- Add base paper categories and more aliases. ([#21](https://github.com/eonu/arx/pull/21))

## 0.2.0

### Major changes

- Flatten provided values in `Arx::Paper`'s field instance methods (allow an array as the `values` splat parameter). ([#5](https://github.com/eonu/arx/pull/5))
- Add `Arx.find` and `Arx.get` as aliases for `Arx.search`. ([#6](https://github.com/eonu/arx/pull/6), [#8](https://github.com/eonu/arx/pull/8))

### Minor changes

- Add `homepage` and `metadata` fields to `arx.gemspec`. ([#1](https://github.com/eonu/arx/pull/1), [#14](https://github.com/eonu/arx/pull/14))
- Specify required ruby version (`~> 2.5`) in `arx.gemspec`. ([#2](https://github.com/eonu/arx/pull/2))
- Add badges to `README.md`. ([#3](https://github.com/eonu/arx/pull/3), [#9](https://github.com/eonu/arx/pull/9))
- Fix documentation for `Arx::Paper`'s field methods `exact` argument. ([#4](https://github.com/eonu/arx/pull/4))
- Update documentation links in `arx.gemspec` and `README.md`. ([#7](https://github.com/eonu/arx/pull/7))
- Remove newline from end of `Gemfile`. ([#11](https://github.com/eonu/arx/pull/11))
- Add ruby-head version to RVM rubies in `.travis.yml`. ([#12](https://github.com/eonu/arx/pull/12))
- Remove unnecessary git-ignored files. ([#13](https://github.com/eonu/arx/pull/13), [#10](https://github.com/eonu/arx/pull/10))

## 0.1.0

Initial commit! 🎉