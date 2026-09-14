class WireConnect < Formula
  desc "Encrypted peer-to-peer networking with NAT traversal and relay fallback"
  homepage "https://github.com/k0ngk0ng/wire-connect"
  version "1.3.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.3.1/wire-connect-1.3.1-darwin-arm64.tar.gz"
    sha256 "8a73f20f67d3679397bdea668818f2d2a798632e0eb2d64ba12ccba00700e306"
  end

  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.3.1/wire-connect-1.3.1-linux-arm64.tar.gz"
      sha256 "a135785d79276ca5a7d261515fddb3db13211e4a538a469f160bbba514aaef98"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-connect/releases/download/v1.3.1/wire-connect-1.3.1-linux-amd64.tar.gz"
      sha256 "b3e77d6ea29ce68ce507fff36b27836e9bcb678ce3702b29fe0717b82d6fb42c"
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
