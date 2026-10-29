# frozen_string_literal: true

module ActiveJob
  module PerformLater
    # `perform_later` entry point, mixed into Object.
    module Mixin
      # Returns a proxy that enqueues the next method call as an Active
      # Job instead of invoking it.
      #
      # @api public
      # @param options [Hash] Active Job set options (`:queue`, `:wait`,
      #   `:wait_until`, `:priority`, ...)
      # @return [Proxy] proxy enqueueing method calls on this receiver
      # @example
      #   Newsletter.perform_later(queue: :low).deliver_all
      def perform_later(**options)
        Proxy.new(self, options)
      end

      # Returns a proxy that builds the next method call as an Active Job
      # without enqueuing it, resolved and checked like {#perform_later}.
      #
      # @api public
      # @param options [Hash] Active Job set options (`:queue`, `:wait`,
      #   `:wait_until`, `:priority`, ...)
      # @return [Proxy] proxy building jobs for method calls on this receiver
      # @example Hand a call to a Solid Queue batch callback
      #   SolidQueue::Batch.enqueue(on_finish: import.job_later.finalize!) { ... }
      def job_later(**options) = Proxy.new(self, options, enqueue: false)
    end
  end
end
