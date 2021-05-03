require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.15", revision: "0e698b421e50dce776275501d9c40a4afb11ffa4"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.15"

    sha256 cellar: :any, catalina: "dff988b47ec4691f57f147dbdf905ed0286723b125928873c3a7fb26e3f34ae8"
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
