class CloogAT018 < Formula
  desc "CLooG is a software which generates loops for scanning Z-polyhedra"
  homepage "https://gcc.gnu.org/wiki/CLooG"
  url "https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz"
  sha256 "02500a4edd14875f94fe84cbeda4290425cb0c1c2474c6f75d75a303d64b4196"
  license "LGPL-2.1-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "ead03f190330ee52bead39f8d29fdb67667882b5acecaa490f6d63c2bc750cac"
    sha256 cellar: :any,                 arm64_ventura:  "cead91fed1a94c7121eb28dbd53060c3bf70a83c62a0546e50d2ec486e1e1e63"
    sha256 cellar: :any,                 arm64_monterey: "9d8c88f5f09bcc01984b15f0ba5d2fe143ee4e129f7dafce268cb36831f33480"
    sha256 cellar: :any,                 arm64_big_sur:  "c0c6fe61fc3cab274494d0afc7c1d3391b58890544efd5f43e4ab13c3c7fccfe"
    sha256 cellar: :any,                 sonoma:         "df4fcfc84b3e7d63f3443caca892be8d75bcd7d59f42ec2353d8358f646253db"
    sha256 cellar: :any,                 ventura:        "d46074ebafa3ac16eedd35381930c80446da0db12109746fc39ad316dc9f98a2"
    sha256 cellar: :any,                 monterey:       "3a6c23a37dcb685ec5ecdd08921dcad09c121d3e0763c0df609e6a9c85fcd964"
    sha256 cellar: :any,                 big_sur:        "9e572d9cca3d5da40666ea38027e38e4189f8c8471d4fe12376828f234b12721"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e0f9fc5de0ae2ddc6bc734ae97b67cf0173ba90da90db87f5402d36c3bcc0ef6"
  end

  depends_on "pkg-config" => :build
  depends_on "gmp"
  depends_on "isl@011"

  def install
    # Avoid doc build.
    ENV["ac_cv_prog_TEXI2DVI"] = ""

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-gmp=system",
                          "--with-gmp-prefix=#{Formula["gmp"].opt_prefix}",
                          "--with-isl=system",
                          "--with-isl-prefix=#{Formula["isl@011"].opt_prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cloog").write <<~EOS
      c

      0 2
      0

      1

      1
      0 2
      0 0 0
      0

      0
    EOS

    assert_match %r{Generated from #{testpath}/test.cloog by CLooG},
                 shell_output("#{bin}/cloog #{testpath}/test.cloog")
  end
end
