# frozen_string_literal: true

require "simplecov"
require "undercover/simplecov_formatter"

SimpleCov.start do
  minimum_coverage 95
  coverage(:line) { minimum 70, per: :file }
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Undercover
    ]
  )
end

require "cgi/escape"
require "active_job"
require "global_id"
require "activejob-later"
require "minitest/autorun"

GlobalID.app = "ajpl-test"
ActiveJob::Base.queue_adapter = :test
ActiveJob::Base.logger = Logger.new(nil)
ActiveSupport.test_order = :random

require_relative "support/fixtures"

class AJPLTestCase < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers
end
