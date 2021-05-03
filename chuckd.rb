require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.13", revision: "42c5abc15d276914d823e8eef9d7810d79697d83"
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
