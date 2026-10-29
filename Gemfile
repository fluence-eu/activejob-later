# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "minitest"
gem "rake"

# Generates the per-activejob-version Gemfiles under gemfiles/ for the CI matrix.
gem "appraisal", require: false

# Curated dev/CI tooling — pulls in rubocop, reek, flog, flay, yard,
# yardstick, simplecov, undercover (and brakeman + bundler-audit +
# ruby_audit which a pure gem doesn't actually invoke but the install
# overhead is negligible). All pins live in the meta-gem; bumping a
# tool here is `bundle update guardian-ci`.
# https://github.com/fluence-eu/guardian-ci
gem "guardian-ci", require: false
