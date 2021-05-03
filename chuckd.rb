require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.18", revision: "2dfc05010b18b91c3809b485b7f42890eed30879"

  bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.18"

    sha256 cellar: :any, catalina: "b75c884c6170b2338a42b9af5737cad62d8283bfe5842119251d7ec6c4a41c84"
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
