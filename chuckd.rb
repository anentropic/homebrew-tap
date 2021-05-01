require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd/archive/refs/tags/untagged-45166c644f5ac67d7ebe.tar.gz"
  version "0.2.0"
  sha256 "68e4deea7f41602f2d4e63ff06bb7fbb1c7e269c6cfa8a43bb0e47aabe6a8774"
  license "Apache-2.0"

  depends_on "gradle" => :build
  depends_on xcode: :build
  depends_on "bats-core" => :test
  depends_on GraalVMRequirement

  def install
    system "gu", "install", "native-image"
    system "gradle", "nativeImage"

    bin.install "app/build/bin/chuckd"

    testpath.install "bat-tests"
  end

  test do
    system bin/"chuckd", "--version"
    system "bats", "bat-tests/smoke.bats"
  end
end
