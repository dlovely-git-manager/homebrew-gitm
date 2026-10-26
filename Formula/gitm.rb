class Gitm < Formula
  desc "Manage local Git repository directories."
  homepage "https://cnb.cool/dlovely-public/git-manager"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.2.0/gitm-aarch64-apple-darwin.tar.gz"
      sha256 "14f70c0d6bcfeb6ddfc041ee9c9f249c53c4258ab56160fb63ae96f2a3cb9ac5"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.2.0/gitm-aarch64-apple-darwin.tar.gz"
      sha256 "14f70c0d6bcfeb6ddfc041ee9c9f249c53c4258ab56160fb63ae96f2a3cb9ac5"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.2.0/gitm-x86_64-apple-darwin.tar.gz"
      sha256 "f748b6aeeca17af533b51eb23b9fe67b8095be5baf9b7958da2ceca6314be399"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.2.0/gitm-x86_64-apple-darwin.tar.gz"
      sha256 "f748b6aeeca17af533b51eb23b9fe67b8095be5baf9b7958da2ceca6314be399"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.2.0/gitm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "614c27c985ce52207ad19c339424d79f14083b454bdd0be97324d1abe725e8c3"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.2.0/gitm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "614c27c985ce52207ad19c339424d79f14083b454bdd0be97324d1abe725e8c3"
    end
    if Hardware::CPU.intel?
      url "https://cnb.cool/dlovely-public/git-manager/-/releases/download/v1.2.0/gitm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c80cb7a7ff5c3fdd04244a00402ec38d12a69d49d57b72854e57197c1dbec10b"
      mirror "https://github.com/dlovely-public/git-manager/releases/download/v1.2.0/gitm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c80cb7a7ff5c3fdd04244a00402ec38d12a69d49d57b72854e57197c1dbec10b"
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
