# typed: false
require "spec_helper"
require "open3"

describe LedgerGen do
  it "has a version number" do
    expect(LedgerGen::VERSION).not_to be nil
  end

  it "should typecheck" do
    stdout, stderr, status = Open3.capture3('bundle exec srb tc')
    if status.exitstatus != 0
      raise stdout + stderr
    end
  end
end
