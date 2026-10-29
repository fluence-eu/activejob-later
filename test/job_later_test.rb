# frozen_string_literal: true

require "test_helper"

class ArchiveService
  perform_later_job :archive do
    queue_as :archives
  end

  def self.archive(label); end
end

class JobLaterTest < AJPLTestCase
  setup { TestService::RESULTS.clear }

  test "returns the job without enqueuing it" do
    assert_no_enqueued_jobs do
      job = TestService.job_later.build("x", upcase: true)
      assert_kind_of ActiveJob::PerformLater::Job, job
      assert_equal ["TestService", "build", ["x"], { upcase: true }], job.arguments
    end
  end

  test "resolves the dedicated job like perform_later" do
    assert_instance_of ArchiveService::ArchivePerformLaterJob, ArchiveService.job_later.archive("q3")
  end

  test "applies the options to the job" do
    freeze_time do
      job = TestService.job_later(queue: :low, priority: 5, wait: 10.minutes).build("x")
      assert_equal "low", job.queue_name
      assert_equal 5, job.priority
      assert_equal 10.minutes.from_now, job.scheduled_at
    end
  end

  test "the deserialized job replays the call" do
    ActiveJob::Base.execute(TestService.job_later.build("x", 2).serialize)
    assert_equal [["x", 2]], TestService::RESULTS
  end

  test "typo raises NoMethodError" do
    error = assert_raises(NoMethodError) { TestService.job_later.buidl("x") }
    assert_match(/'buidl'/, error.message)
  end

  test "string targets raise ArgumentError" do
    assert_raises(ArgumentError) { "TestService".job_later.upcase }
  end
end
