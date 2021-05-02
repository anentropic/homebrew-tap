require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.8", revision: "8bf166cc75d8980866473513142b716222e15fc2"



  version "0.3.8"
  sha256 "68e4deea7f41602f2d4e63ff06bb7fbb1c7e269c6cfa8a43bb0e47aabe6a8774"
  license "Apache-2.0"

  depends_on "gradle" => :build
  depends_on xcode: :build
  depends_on GraalVMRequirement

  def install
    system "gradle", "nativeImage"
    bin.install "app/build/bin/chuckd"
  end

  test do
    system bin/"chuckd", "--version"
  end
end
