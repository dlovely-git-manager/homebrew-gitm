class Gitm < Formula
  desc "Manage local Git repository directories."
  homepage "https://cnb.cool/dlovely-public/git-manager"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/gitm-aarch64-apple-darwin.tar.gz"
      sha256 "24e5eee9b104ff5e448bc71e123defa6b9fe2623d70bffddf6593b262b1a2ffe"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/gitm-aarch64-apple-darwin.tar.gz"
      sha256 "24e5eee9b104ff5e448bc71e123defa6b9fe2623d70bffddf6593b262b1a2ffe"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/gitm-x86_64-apple-darwin.tar.gz"
      sha256 "c7c3bfb1c6e9d1bf45a4509aba364b6c796c8de2e7b4ef0605a74146460d88ac"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/gitm-x86_64-apple-darwin.tar.gz"
      sha256 "c7c3bfb1c6e9d1bf45a4509aba364b6c796c8de2e7b4ef0605a74146460d88ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/gitm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "88fde0cc0e3c920c4c3b578720e09d1962002a9ae999e6448b72c1eec6388be3"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/gitm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "88fde0cc0e3c920c4c3b578720e09d1962002a9ae999e6448b72c1eec6388be3"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.1.0/gitm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "758a5260b3e556dd85ee8c1d454d7a79131dcbab2ab174fc9e4534ff29408a89"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.1.0/gitm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "758a5260b3e556dd85ee8c1d454d7a79131dcbab2ab174fc9e4534ff29408a89"
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
