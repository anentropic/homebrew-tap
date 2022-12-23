class Chuckd < Formula
  desc "Schema evolutions validation tool, for JSON Schema, Protobuf and Avro"
  homepage "https://github.com/anentropic/chuckd/"
  url "https://github.com/anentropic/chuckd.git", tag: "0.5.3", revision: "684020c3a0b2d34350c5c81f5b3e46174eb0b381"
  license "Apache-2.0"

  depends_on "gradle" => :build
  depends_on "bats-core" => :test
  depends_on "openjdk"

  def install
    system "gradle", "--no-daemon", "-Dorg.gradle.java.home=#{HOMEBREW_PREFIX}/opt/openjdk/", "build"

    system "unzip", "app/build/distributions/app-shadow-#{version}.zip"
    libexec.install Dir["app-shadow-#{version}/lib/*"]
    write_non_overridable_jar_script bin, libexec/"chuckd-#{version}-all.jar", "chuckd"

    (info/"test/resources").install Dir["app/src/test/resources/*"]
    (info/"bat-tests").install Dir["bat-tests/*"]
  end

  # see https://rubydoc.brew.sh/Pathname#write_jar_script-instance_method
  # we want to force use of the homebrew openjdk version that we built our jar with
  # so that we can be sure it works (write_jar_script allows override by JAVA_HOME)
  def write_non_overridable_jar_script(base_path, target_jar, script_name, java_opts = "", java_version: nil)
    mkpath base_path
    (base_path/script_name).write <<~EOS
      #!/bin/bash
      export JAVA_HOME="#{Language::Java.java_home_env(java_version)[:JAVA_HOME]}"
      exec "${JAVA_HOME}/bin/java" #{java_opts} -jar "#{target_jar}" "$@"
    EOS
  end

  test do
    with_env(
      "CHUCKD_BIN_PATH" => bin,
      "CHUCKD_RES_PATH" => "#{info}/test/resources",
    ) do
      system "bats", "#{info}/bat-tests/smoke.bats"
    end
  end
end
