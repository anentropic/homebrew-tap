require_relative "./require/graalvm"

class Chuckd < Formula
  desc "Schema evolutions validator"
  homepage "https://github.com/anentropic/chuckd"
  url "https://github.com/anentropic/chuckd.git", tag: "0.3.9", revision: "e0b0eea7ea590f68ddf522d65c6b29d199987284"

bottle do
    root_url "https://github.com/anentropic/chuckd/releases/download/0.3.9"
    
    sha256 cellar: :any, catalina: "69ebb1365e89bf511625e17fdcedd285d506fa53c70be4e3629f702f5f776e40"
  end


  

  sha256 "68e4deea7f41602f2d4e63ff06bb7fbb1c7e269c6cfa8a43bb0e47aabe6a8774"
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
