class Gitm < Formula
  desc "Manage local Git repository directories."
  homepage "https://cnb.cool/dlovely-public/git-manager"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/git-manager-aarch64-apple-darwin.tar.gz"
      sha256 "02cb0fb0eec7bf3f100626d57409304f810e152ef31746a694c06112e4263594"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/git-manager-aarch64-apple-darwin.tar.gz"
      sha256 "02cb0fb0eec7bf3f100626d57409304f810e152ef31746a694c06112e4263594"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/git-manager-x86_64-apple-darwin.tar.gz"
      sha256 "62eccaf98a14a8f903eb49f2cfc84756889124533e40bae063e14c69a72a417f"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/git-manager-x86_64-apple-darwin.tar.gz"
      sha256 "62eccaf98a14a8f903eb49f2cfc84756889124533e40bae063e14c69a72a417f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/git-manager-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e751ffced6cc753c72bce0fed6063334388fee44eb11d3ec8e1515d2555687a"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/git-manager-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e751ffced6cc753c72bce0fed6063334388fee44eb11d3ec8e1515d2555687a"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/git-manager-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36c6fc208379dcb7b6c0322145ffaf3611d6b3bc1089b979a38282f672923433"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/git-manager-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36c6fc208379dcb7b6c0322145ffaf3611d6b3bc1089b979a38282f672923433"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gitm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gitm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gitm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gitm"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
