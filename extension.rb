# frozen_string_literal: true

# This class represents a Homebrew formula for the extension project.
class Extension < Formula
  url 'https://github.com/8ta4/extension/releases/download/v0.3.2/extension.tar.gz'
  sha256 '0e127160dbb6165b7cedfd1a63224a2d1f502f853adb3021705527c00904eb85'
  depends_on 'node'
  def install
    libexec.install Dir['*']
    (bin / 'extension').write <<~SHELL
      #!/bin/sh
      exec "#{Formula['node'].opt_bin}/node" "#{libexec}/main.js" "$@"
    SHELL
  end
end
