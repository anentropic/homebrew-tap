require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.12", revision: "31ed95258cbb3e9601ec512410a8a408c0a95e19"

    bottle do
      root_url "https://github.com/anentropic/chuckd/releases/download/0.3.12"

      sha256 cellar: :any, catalina: "ef7d84832fc50a542676bf2ff83fce1f3c584e7242ce66d5b652db0914ea1786"
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
