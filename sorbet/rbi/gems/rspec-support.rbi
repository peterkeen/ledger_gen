# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/rspec-support/all/rspec-support.rbi
#
# rspec-support-3.5.0

module RSpec
  extend RSpec::Support::Warnings
end
module RSpec::Support
  def self.define_optimized_require_for_rspec(lib, &require_relative); end
  def self.failure_notifier; end
  def self.failure_notifier=(callable); end
  def self.method_handle_for(object, method_name); end
  def self.notify_failure(failure, options = nil); end
  def self.require_rspec_support(f); end
  def self.thread_local_data; end
  def self.warning_notifier; end
  def self.warning_notifier=(arg0); end
  def self.with_failure_notifier(callable); end
end
module RSpec::Support::AllExceptionsExceptOnesWeMustNotRescue
  def self.===(exception); end
end
module RSpec::Support::Warnings
  def deprecate(deprecated, options = nil); end
  def warn_deprecation(message, options = nil); end
  def warn_with(message, options = nil); end
  def warning(text, options = nil); end
end
module RSpec::Support::FuzzyMatcher
end
