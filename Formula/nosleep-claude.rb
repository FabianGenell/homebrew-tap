class NosleepClaude < Formula
  desc "Keep macOS awake while the Claude Code CLI is running"
  homepage "https://github.com/FabianGenell/nosleep-claude"
  url "https://github.com/FabianGenell/nosleep-claude/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "748b943c6c7c766c99f4c8fe5558867d38fb933cfd40d98249e5312f1d17d1ed"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/nosleep-claude"
  end

  service do
    run [opt_bin/"nosleep-claude"]
    keep_alive true
    log_path var/"log/nosleep-claude.log"
    error_log_path var/"log/nosleep-claude.log"
    process_type :background
  end

  def caveats
    <<~EOS
      To start the daemon (and auto-start at login):
        brew services start nosleep-claude

      Optional — prevent sleep when the lid is closed on battery:
        sudo nosleep-claude install-sudoers

      Check status:
        nosleep-claude status

      Logs:
        tail -f #{var}/log/nosleep-claude.log
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nosleep-claude --version")
  end
end
