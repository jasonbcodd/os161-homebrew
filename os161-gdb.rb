class Os161Gdb < Formula
  homepage "http://os161.eecs.harvard.edu/"
  url "http://os161.eecs.harvard.edu/download/gdb-7.8+os161-2.1.tar.gz"
  version "7.8-os161-2.1"
  sha256 "1c16e2d83b3bfe52e8133e3c3a7d1f083b2d010fe1c107a78ede6439b1b1fe61"
  revision 3

  depends_on "pkg-config" => :build
  depends_on "readline"
  depends_on "python@2"

  patch do
    url "https://raw.githubusercontent.com/jasonbcodd/os161-homebrew/main/patches/gdb.patch"
	sha256 "8185b44b73a1b9a9c35922f665d0131d0ac0bd66b0adbfcf34706d1d42e8122b"
  end	
	
  def install
    args = [
      "--prefix=#{prefix}",
      "--with-gdb-datadir=#{share}/mips-harvard-os161-gdb",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-python=#{Formula["python@2"].opt_prefix}",
      "--without-lzma",
      "--target=mips-harvard-os161",
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    bin.install_symlink bin/"mips-harvard-os161-gdb" => "os161-gdb"

    # Remove conflicting items with binutils and stock GDB.
    rm_rf include
    rm_rf lib
    rm_rf share/"info"
    rm_rf share/"locale"
    rm_rf share/"man"
  end
end
