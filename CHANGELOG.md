# Changelog

All notable changes to this project will be documented in this file.
## [2026.10.29.162056] - 2026-10-29

### Added

- feat: add job_later to build a job without enqueuing it

### Build

- build: quote VERSION the way the release bump expects
- build: point repository links at fluence-eu/activejob-later
- build!: rename the gem to activejob-later
- build!: require Ruby 3.3
- build: move to guardian-ci and ci-workflows@v7
- build: add fluence-ci-tools tooling and gem metadata

### CI

- ci: publish the gem to rubygems.org
- ci: test every supported activejob minor through Appraisal
- ci: align the workflows on guardian-ci
- ci: wire fluence-eu/ci-workflows@v6 gates and release flow

### Documentation

- docs: attribute pre-tag history to the v0.1.0 changelog section
- docs: add changelog and contributing guide
- docs: document the public API and wire the yardstick gate

### Other

- chore(license): assign the copyright to Fluence

### Style

- style: add rubocop config aligned with the existing code style

### Tests

- test: enforce coverage thresholds with SimpleCov and Undercover

## [0.1.0] - 2026-07-02

### Added

- Add MIT license
- Add README
- Add on: scope to per-method jobs
- Add per-method perform_later_job
- Add perform_later_job class-level macro
- Add universal perform_later proxy for class methods
- Add gem scaffolding

### Other

- Trim unused DualRecord fixture code
- Cover class call ignoring instance-scoped job
- Defer generic job definition to the active_job load hook
- Reject blocks passed to proxied calls
- Document macro ordering and proxy forwarding
- Reject String targets with a clear error
- Make proxy inspect safe for consoles
- Make the generated jobs base class configurable
- Cover top-level constant anti-leak in job resolution
- Make vanished-class test cleanup exception-safe
- Lock fail-fast error contracts
- Lock enqueue options passthrough contract
- Cover module and GlobalID instance targets
- Use cgi/escape to avoid Ruby 4 CGI deprecation warning

