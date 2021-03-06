# frozen_string_literal: true

# rubocop:disable Style/ClassVars
# rubocop:disable Style/StringLiteralsInInterpolation
class GraalVMRequirement < Requirement
  fatal true

  satisfy(build_env: false) { self.class.graalvm_installed? }

  @@graal_root = nil

  def self.graalvm_installed?
    if ENV["HOMEBREW_GRAALVM_HOME"]
      # for GitHub Actions:
      File.exist?("#{ENV['HOMEBREW_GRAALVM_HOME']}/bin/native-image")
    else
      # for local install:
      @@graal_root = `echo $(find /Library/Java/JavaVirtualMachines -name "graalvm-ce-java*")`
                     .split(/\n+|\r+/)
                     .reject(&:empty?)[0]
      ohai "Found GraalVM installation: #{@@graal_root}"
      File.exist?("#{@@graal_root}/Contents/Home/bin/native-image")
    end
  end

  env do
    if ENV["HOMEBREW_GRAALVM_HOME"]
      # for GitHub Actions:
      ENV.append_path "PATH", "#{ENV['HOMEBREW_GRAALVM_HOME']}/bin"
      ENV["JAVA_HOME"] = ENV["HOMEBREW_GRAALVM_HOME"]
    else
      # for local install:
      ohai @@graal_root.to_s
      ENV.append_path "PATH", "#{@@graal_root}/Contents/Home/bin"
      ENV["JAVA_HOME"] = "#{@@graal_root}/Contents/Home"
    end
  end

  def message
    "This formula requires GraalVM and the native-image build tool.\n"\
    "Please run `brew install --cask graalvm/tap/graalvm-ce-java11` first.\n"\
    "See https://github.com/graalvm/homebrew-tap for more detailed instructions.\n"\
    "`gu install native-image` requires admin permissions, you will have to do it manually.\n"\
    "(Please install the java11 version, that's what chuckd is developed against).\n"\
    "If you installed GraalVM to a location other than the suggested `/Library/Java/JavaVirtualMachines/`"\
    " path then you will need to set HOMEBREW_GRAALVM_HOME=$JAVA_HOME env var in front of"\
    " `brew install anentropic/tap/chuckd`."
  end
end
# rubocop:enable Style/StringLiteralsInInterpolation
# rubocop:enable Style/ClassVars
