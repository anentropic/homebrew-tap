# frozen_string_literal: true

class GraalVMRequirement < Requirement
  fatal true

  satisfy(build_env: false) { self.class.graalvm_installed? }

  @graal_root = nil

  def self.graalvm_installed?
    @graal_root = `echo $(find /Library/Java/JavaVirtualMachines -name "graalvm-ce-java*")`.strip
    File.exist?("#{@graal_root}/Contents/Home/bin/gu")
  end

  env do
    ohai @graal_root.to_s
    ENV.append_path "PATH", "#{@graal_root}/Contents/Home/bin"
    ENV["JAVA_HOME"] = "#{@graal_root}/Contents/Home"
  end

  def message
    "This formula requires GraalVM.\n"\
    "Please run `brew install --cask graalvm/tap/graalvm-ce-java11` first.\n"\
    "See https://github.com/graalvm/homebrew-tap for more detailed instructions.\n"\
    "(Please install the java11 version, that's what chuckd is developed against)."
  end
end
