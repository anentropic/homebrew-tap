require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.17", revision: "1b1deff89f24a53c4a932cedd7d234113398d29f"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.17"

    sha256 cellar: :any, catalina: "d0e55f94db69bbea0dfcedaf51cf573bc268b8bd9deda100eaa28cd05c5bc95f"
  end

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
