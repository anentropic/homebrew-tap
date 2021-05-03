require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.14", revision: "25fa980295c7c61698994b97dc223a6b926e9edd"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.14"

    sha256 cellar: :any, catalina: "2b2204f39dd2698de4036634e35c963f4ee85e0748ffca86a9918154c069b90a"
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
