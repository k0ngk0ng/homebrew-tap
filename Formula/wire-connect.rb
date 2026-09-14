class WireConnect < Formula
  desc "Encrypted peer-to-peer networking with NAT traversal and relay fallback"
  homepage "https://github.com/k0ngk0ng/wire-connect"
  version "1.4.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.4.1/wire-connect-1.4.1-darwin-arm64.tar.gz"
    sha256 "94ed180dfc57788f418ca05c46f2ae2e1050f730cd6e9629c61d3760f57ecae0"
  end

  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.4.1/wire-connect-1.4.1-linux-arm64.tar.gz"
      sha256 "81cf56257b01454405f6380976a44b86cff492125548cca74e4325b28102b1a0"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.4.1/wire-connect-1.4.1-linux-amd64.tar.gz"
      sha256 "66a818213830c8abde302731000d6130e2e5285164e54c7c92bd7ed95e793e2e"
    end
  end

  depends_on "k0ngk0ng/tap/wirectl"

  def install
    libexec.install "bin/wirectl-connect"
    (libexec/".wire-connect-package-manager").write "homebrew\n"
    bin.install_symlink libexec/"wirectl-connect"
    generate_completions_from_executable(bin/"wirectl-connect", "completion",
                                         base_name: "wirectl", shells: [:bash])
    bash_completion.install_symlink bash_completion/"wirectl" => "wirectl-connect"
    completion = Utils.safe_popen_read(bin/"wirectl-connect", "completion", "zsh")
    (zsh_completion/"_wirectl").write "#compdef wirectl wirectl-connect\n#{completion}\n_wirectl_connect_completion \"$@\"\n"
  end

  def caveats
    <<~EOS
      Run as your regular user after install or upgrade:
        wirectl connect setup
        wirectl connect resume
      setup requests administrator authorization for the network helper.
      resume uses an existing pair. Pair new devices before using resume.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/wirectl-connect version").strip
    output = shell_output("#{bin}/wirectl-connect update 2>&1", 1)
    assert_match "brew upgrade k0ngk0ng/tap/wire-connect", output
  end
end
