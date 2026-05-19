class NosleepClaude < Formula
  desc "Keep macOS awake while the Claude Code CLI is running"
  homepage "https://github.com/FabianGenell/nosleep-claude"
  url "https://github.com/FabianGenell/nosleep-claude/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1ba9e60035e8c9a11ad502d1a53a94f372fc77ac58d143f53032a549b2352af6"
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
