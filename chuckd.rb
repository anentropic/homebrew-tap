require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.4.1", revision: "d92278508c306b0975a5bfbc26f1323aac79472f"

  license "Apache-2.0"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.4.1"

    sha256 cellar: :any, catalina: "dbed63d3b473849e72556c68a68c21f8297eadbd158be5a2c00c5c4827f3ad8e"
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
