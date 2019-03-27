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