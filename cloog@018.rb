class CloogAT018 < Formula
  desc "CLooG is a software which generates loops for scanning Z-polyhedra"
  homepage "https://gcc.gnu.org/wiki/CLooG"
  url "https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz"
  sha256 "02500a4edd14875f94fe84cbeda4290425cb0c1c2474c6f75d75a303d64b4196"
  license "LGPL-2.1-or-later"

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
