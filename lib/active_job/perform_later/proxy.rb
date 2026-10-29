# frozen_string_literal: true

module ActiveJob
  module PerformLater
    # Intermediate object returned by {Mixin#perform_later} and
    # {Mixin#job_later}: captures the next method call and enqueues — or
    # only builds — it instead of invoking it.
    #
    # @api private
    class Proxy < BasicObject
      # @api private
      # @param target [Object] receiver the call will be replayed on
      # @param options [Hash] Active Job set options
      # @param enqueue [Boolean] false to build the job without enqueuing it
      # @return [Proxy] a new proxy around target
      def initialize(target, options, enqueue: true)
        @target = target
        @options = options
        @enqueue = enqueue
      end

      # Enqueues — or only builds, for {Mixin#job_later} — `method_name`
      # on the captured target through the job class resolved by
      # {PerformLater.job_for}.
      #
      # @api private
      # @return [ActiveJob::Base] the enqueued, or built, job instance
      # @raise [NoMethodError] when the target does not respond to the
      #   method
      # @raise [ArgumentError] when a block is passed — blocks are not
      #   serializable
      def method_missing(method_name, *args, **kwargs, &block)
        unless @target.respond_to?(method_name)
          ::Kernel.raise ::NoMethodError,
                         "undefined method '#{method_name}' for #{@target.inspect} (via perform_later)"
        end

        if block
          ::Kernel.raise ::ArgumentError,
                         "cannot enqueue '#{method_name}' with a block — blocks are not serializable"
        end

        job = PerformLater.job_for(@target, method_name)
        arguments = [PerformLater.target_ref(@target), method_name.to_s, args, kwargs]
        return job.new(*arguments).set(@options) unless @enqueue

        job.set(**@options).perform_later(*arguments)
      end

      # Human-readable description of the proxy.
      #
      # @api private
      # @return [String] the captured target and options
      def inspect
        "#<ActiveJob::PerformLater::Proxy target=#{@target.inspect} options=#{@options.inspect}>"
      end
    end
  end
end
