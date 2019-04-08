# 1.0.0

#### Major changes

- Change `Query` connective instance methods ([#38](https://github.com/eonu/arx/pull/38)):
  - `#&` -> `#and`
  - `#|` -> `#or`
  - `#!` -> `#and_not`
- Split version number from paper identifier in `Paper` (add `version` key-word argument to `#id` and `#url`, and add `#version`). ([#39](https://github.com/eonu/arx/pull/39))
- Add `Cleaner.extract_id` and `Cleaner.extract_version`. ([#39](https://github.com/eonu/arx/pull/39))
- Make `Query#add_connective` always return `self`. ([#40](https://github.com/eonu/arx/pull/40))
- Redefine `Arx.search` to user `Paper.parse`'s `search` key-word argument. ([#40](https://github.com/eonu/arx/pull/40))
- Implement all tests. ([#40](https://github.com/eonu/arx/pull/40))

#### Minor changes

- Change declared regular expression literals from `%r""` to standard `//`. ([#39](https://github.com/eonu/arx/pull/39))
- Remove `#extract_id` from `Query` and use `Cleaner.extract_id` instead. ([#39](https://github.com/eonu/arx/pull/39))
- Redefine `Paper#revision?` to use the new `#version` instead of `#updated_at` and`#published_at`. ([#39](https://github.com/eonu/arx/pull/39))

# 0.3.2

#### Major changes

- Add `Paper#category` alias for `Paper#primary_category`. ([#34](https://github.com/eonu/arx/pull/34))
- Change `Author#affiliations?` to `Author#affiliated?`. ([#34](https://github.com/eonu/arx/pull/34))
- Change `Paper#last_updated` to `Paper#updated_at` (and remove `updated_at` alias). ([#34](https://github.com/eonu/arx/pull/34))
- Change `Paper#publish_date` to `Paper#published_at` (and remove `published_at` alias). ([#34](https://github.com/eonu/arx/pull/34))
- Conditionally assign query object in `Arx.search` with `||=` operator. ([#33](https://github.com/eonu/arx/pull/33))
- Add `gem:debug` rake task for loading the gem into an interactive console. ([#28](https://github.com/eonu/arx/pull/28))
- Add `gem:release` rake task for preparing gem releases. ([#36](https://github.com/eonu/arx/pull/36))
- Add `thor` gem development dependency. ([#36](https://github.com/eonu/arx/pull/36))

#### Minor changes

- Update documentation links to `rubydoc.info`'s GitHub service. ([#30](https://github.com/eonu/arx/pull/30))
- Add email address to `LICENSE`. ([#31](https://github.com/eonu/arx/pull/31))
- Improve `Error::MissingField` and `Error::MissingLink` error messages. ([#35](https://github.com/eonu/arx/pull/35))

# 0.3.1

#### Major changes

- Add `.yardopts` for document generation configuration. ([#26](https://github.com/eonu/arx/pull/26))
- Namespace errors in `Arx::Error` module and remove `Error` prefix from error classes. ([#26](https://github.com/eonu/arx/pull/26))
- Move identifier format regular expression constant definitions from `Arx::Validate` to top-level namespace `Arx`. ([#26](https://github.com/eonu/arx/pull/26))

#### Minor changes

- Rename `lib/arx/exceptions.rb` to `lib/arx/errors.rb`. ([#26](https://github.com/eonu/arx/pull/26))
- Make `Arx::Cleaner`, `Arx::Validate`, `Arx::Inspector`, `Arx::Link` private (hidden from `yard` documentation). ([#26](https://github.com/eonu/arx/pull/26))

# 0.3.0

#### Major changes

- Add documentation, images, installation and usage instructions to `README.md`. ([#22](https://github.com/eonu/arx/pull/22), [#17](https://github.com/eonu/arx/pull/17))
- Allow prior construction of a search query in `Arx.search`. ([#18](https://github.com/eonu/arx/pull/18))
- Fix `Arx.search` query object yielding. ([#20](https://github.com/eonu/arx/pull/20))

#### Minor changes

- Remove conditional with `block_given?` in `Arx()` method. ([#16](https://github.com/eonu/arx/pull/16))
- Remove leading ampersand (&) from search query string. ([#19](https://github.com/eonu/arx/pull/19))
- Add base paper categories and more aliases. ([#21](https://github.com/eonu/arx/pull/21))

# 0.2.0

#### Major changes

- Flatten provided values in `Arx::Paper`'s field instance methods (allow an array as the `values` splat parameter). ([#5](https://github.com/eonu/arx/pull/5))
- Add `Arx.find` and `Arx.get` as aliases for `Arx.search`. ([#6](https://github.com/eonu/arx/pull/6), [#8](https://github.com/eonu/arx/pull/8))

#### Minor changes

- Add `homepage` and `metadata` fields to `arx.gemspec`. ([#1](https://github.com/eonu/arx/pull/1), [#14](https://github.com/eonu/arx/pull/14))
- Specify required ruby version (`~> 2.5`) in `arx.gemspec`. ([#2](https://github.com/eonu/arx/pull/2))
- Add badges to `README.md`. ([#3](https://github.com/eonu/arx/pull/3), [#9](https://github.com/eonu/arx/pull/9))
- Fix documentation for `Arx::Paper`'s field methods `exact` argument. ([#4](https://github.com/eonu/arx/pull/4))
- Update documentation links in `arx.gemspec` and `README.md`. ([#7](https://github.com/eonu/arx/pull/7))
- Remove newline from end of `Gemfile`. ([#11](https://github.com/eonu/arx/pull/11))
- Add ruby-head version to RVM rubies in `.travis.yml`. ([#12](https://github.com/eonu/arx/pull/12))
- Remove unnecessary git-ignored files. ([#13](https://github.com/eonu/arx/pull/13), [#10](https://github.com/eonu/arx/pull/10))

# 0.1.0

Initial commit! 🎉