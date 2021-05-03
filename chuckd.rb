require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.19", revision: "ee38272baa1fdd1bbbe71d09da5b576b126a2eca"

  license "Apache-2.0"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.19"

    sha256 cellar: :any, catalina: "d4c76d961664bf6c24ae445b6f5516355dd4c1ffcff562a57767f50bdf19e3ae"
  end

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
