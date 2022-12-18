require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.5.2", revision: "e7e4392d42b19fbc7a93f30f78d2debce521c3be"

  license "Apache-2.0"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.5.2"

    sha256 cellar: :any, catalina: "f1501b3e0e785279c86169d8c323d35f1c1005d86785dc952b3ab3ee132cd160"
    sha256 cellar: :any, Monterey: "008173d3756e9d0edfdfc06dd6f54e371f2599aa69982ad436e6f81f7bb03c52"
  end

  depends_on GraalVMRequirement => :build
  depends_on "gradle" => :build
  depends_on xcode: :build

  def install
    system "gradle", "nativeImage"
    bin.install "app/build/bin/chuckd"
  end

  test do
    system bin/"chuckd", "--version"
  end
end
