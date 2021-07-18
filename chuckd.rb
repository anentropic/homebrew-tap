require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.5.0", revision: "71fdf9e53b077117a8ad65df71d3182ceb0500ae"

  license "Apache-2.0"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.5.0"

    sha256 cellar: :any, catalina: "31f192db2a23c423066d805adf360f5d5abb5b37bc74d4b25e6122a69f370445"
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
