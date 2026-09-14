class WireConnect < Formula
  desc "Encrypted peer-to-peer networking with NAT traversal and relay fallback"
  homepage "https://github.com/k0ngk0ng/wire-connect"
  version "1.2.2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.2.2/wire-connect-1.2.2-darwin-arm64.tar.gz"
    sha256 "50453a4b68a8a9c6bf831f2c5732aa78531bc5c7eecf95806a8185d8a34a4bc2"
  end

  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.2.2/wire-connect-1.2.2-linux-arm64.tar.gz"
      sha256 "39d77c7250f8dc5195c1196bf259732451e4824d77d53845ebfdd3e5d5b70fe5"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.2.2/wire-connect-1.2.2-linux-amd64.tar.gz"
      sha256 "ef8d8c5264ecab1a78c7b350c9be25fbf385fc899a5639ea8147c4b086cffb5e"
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
