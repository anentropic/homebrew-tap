require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.16", revision: "377970f7eca4fb721519999ea133bd5baa94c479"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.16"

    sha256 cellar: :any, catalina: "7dd756448bd86a7e950873396ceae5580deabe25a7cbfc09b36b7a87ce7c1027"
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
