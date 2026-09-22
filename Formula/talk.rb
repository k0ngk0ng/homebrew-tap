class Talk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.3"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.3/wire-talk-0.1.3-darwin-arm64.tar.gz"
      sha256 "967c723546577037a022f864d38c3fa66cd512484538908ff4f6bb2f72aff87a"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.3/wire-talk-0.1.3-darwin-amd64.tar.gz"
      sha256 "8e89de54b9f882e8ec0d54ec57417db7945a036284da7f80720b6f2b7cd694ae"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.3/wire-talk-0.1.3-linux-arm64.tar.gz"
      sha256 "a45a26094902cdd586673f3101350550c4216c86cbc20a38f26067b1d2a9914a"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.3/wire-talk-0.1.3-linux-amd64.tar.gz"
      sha256 "382a3c93baf297a770dd60bdd6b3340101b484b0319733d27fa700d126fc2700"
    end
  end
  def install
    bin.install "bin/wirectl-talk"
    (bin/".wire-talk-package-manager").write "homebrew\n"
    doc.install "README.md", "THIRD_PARTY_NOTICES.md"
    doc.install "licenses"
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/wirectl-talk version")
    system bin/"wirectl-talk", "init", "--state-dir", testpath/"state"
    assert_path_exists testpath/"state/config.json"
  end
end
