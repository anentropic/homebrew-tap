require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.5.3", revision: "684020c3a0b2d34350c5c81f5b3e46174eb0b381"

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
