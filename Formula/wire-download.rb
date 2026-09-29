class WireDownload < Formula
  desc "HTTP, BitTorrent, eD2k, X and YouTube downloads with bundled engines"
  homepage "https://github.com/k0ngk0ng/wire-download"
  version "0.3.1"

  on_macos do
    depends_on macos: :ventura
    depends_on arch: :arm64

    url "https://github.com/k0ngk0ng/wire-download/releases/download/v0.3.1/wire-download-0.3.1-darwin-arm64.tar.gz"
    sha256 "9c566e07bc2bd6b402c7c92c7b0a4df5c34eb2a1f434e31f353b1b3bcd84ebc9"
  end

  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-download/releases/download/v0.3.1/wire-download-0.3.1-linux-arm64.tar.gz"
      sha256 "bff69d35348a59c90731aef41b8c6e29f70ece0474dae73600c2eed9a027a360"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-download/releases/download/v0.3.1/wire-download-0.3.1-linux-amd64.tar.gz"
      sha256 "b1566e513c235a459cab836e37ddad58f62fd87cdb54d9e0d532493bfba0d059"
    end
  end

  depends_on "k0ngk0ng/tap/wirectl"

  def install
    bin.install "bin/wirectl-download"
    libexec.install "libexec/wirectl-download"
    pkgshare.install "README.md", "deploy", "licenses"
    bash_script = Utils.safe_popen_read(bin/"wirectl-download", "completion", "bash")
    bash_script = bash_script.lines.reject { |line| line.start_with?("# bash completion", "# Install with:") || line == "complete -o filenames -F _wirectl_download_completion wirectl\n" }.join
    (bash_completion/"wirectl-download").write bash_script
    zsh_script = Utils.safe_popen_read(bin/"wirectl-download", "completion", "zsh")
    zsh_script = zsh_script.lines.reject { |line| line.start_with?("#compdef ") || line == "compdef _wirectl_download_completion wirectl\n" }.join
    (zsh_completion/"_wirectl-download").write "#compdef wirectl-download\n#{zsh_script}\n_wirectl_download_completion \"$@\"\n"
    fish_script = Utils.safe_popen_read(bin/"wirectl-download", "completion", "fish")
    fish_script = fish_script.lines.reject { |line| line.start_with?("# fish completion") || line == "complete -c wirectl -f -a '(__wirectl_download_complete)'\n" }.join
    (fish_completion/"wirectl-download.fish").write fish_script
  end

  service do
    run [opt_bin/"wirectl-download", "daemon", "run"]
    keep_alive true
  end

  def caveats
    <<~EOS
      Initialize the download state before starting the daemon:
        wirectl download init
      Stop the service before upgrading this formula:
        brew services stop wire-download
      If started manually, use wirectl download daemon stop instead.
      Manage the background daemon with:
        brew services start wire-download
        brew services stop wire-download
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/wirectl-download version").strip
    assert_match "Usage:", shell_output("#{bin}/wirectl-download --help")
    state = testpath/"state"
    downloads = testpath/"downloads"
    mkdir_p downloads
    system bin/"wirectl-download", "--data-dir", state, "init", "--downloads", downloads
    doctor = shell_output("#{bin}/wirectl-download --data-dir #{state} doctor")
    %w[aria2c amuled amulecmd yt-dlp ffmpeg deno].each do |engine|
      assert_match (prefix/"libexec/wirectl-download/bin/#{engine}").to_s, doctor
    end
  end
end
