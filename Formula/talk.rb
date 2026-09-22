class Talk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.0"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.0/wire-talk-0.1.0-darwin-arm64.tar.gz"
      sha256 "334b2489f38bc719c0bd800d95c633d140a46efe6a47049256d812dc620b49c5"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.0/wire-talk-0.1.0-darwin-amd64.tar.gz"
      sha256 "c0496740685c4317c2475c0d011e2439c62454c9e787f4c462c470d11aa1e9d7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.0/wire-talk-0.1.0-linux-arm64.tar.gz"
      sha256 "27773326f56a55968e9a76bc41d652acb840c87cd6da3f3b5148b1924c88299d"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.0/wire-talk-0.1.0-linux-amd64.tar.gz"
      sha256 "881d97853e1c44c60f19e6089a8e9d34c185c4f8e4b9586446a43e5f46f79167"
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
