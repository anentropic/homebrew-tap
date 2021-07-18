require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.4.1", revision: "d92278508c306b0975a5bfbc26f1323aac79472f"

  license "Apache-2.0"

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
