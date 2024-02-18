class Os161Binutils < Formula
  homepage "http://os161.eecs.harvard.edu/"
  url "http://os161.eecs.harvard.edu/download/binutils-2.24+os161-2.1.tar.gz"
  version "2.24-os161-2.1"
  sha256 "7c1221ad538ee2d72ce4b6bad996d701b2a8e21977c0fd7c9bb6020c035ce664"
  revision 3

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--disable-werror",
                          "--target=mips-harvard-os161"
    system "make"
    system "make", "install"

    # Remove conflicting items with binutils and stock GDB.
    rm_rf share/"info"
    rm_rf share/"locale"
    
    linked_binaries = %w[
      addr2line
      ar
      as
      c++filt
      elfedit
      ld
      ld.bfd
      nm
      objcopy
      objdump
      ranlib
      readelf
      size
      strings
      strip
    ]
    
    linked_binaries.each do |binary|
      bin.install_symlink bin/"mips-harvard-os161-#{binary}" => bin/"os161-#{binary}"
    end
  end
end
