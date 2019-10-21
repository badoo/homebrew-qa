class Ffmpeg < Formula
    desc "Play, record, convert, and stream audio and video"
    homepage "https://ffmpeg.org/"
    url "https://ffmpeg.org/releases/ffmpeg-4.1.4.tar.xz"
    sha256 "f1f049a82fcfbf156564e73a3935d7e750891fab2abf302e735104fd4050a7e1"
    version '4.1.4'
    revision 1
    head "https://github.com/FFmpeg/FFmpeg.git"
  
    bottle do
      root_url "https://github.com/badoo/homebrew-qa-bottles/releases/download/v1.0"
      cellar :any
      rebuild 1
      sha256 "b41d6fedd60dbc1e406b01350cebe64f402e2d92945bcc7474c2f4b1838fab0f" => :catalina
      sha256 "b41d6fedd60dbc1e406b01350cebe64f402e2d92945bcc7474c2f4b1838fab0f" => :mojave
      sha256 "b41d6fedd60dbc1e406b01350cebe64f402e2d92945bcc7474c2f4b1838fab0f" => :high_sierra
    end
  
    depends_on "nasm" => :build
    depends_on "pkg-config" => :build
    depends_on "texi2html" => :build
  
    depends_on "aom"
    depends_on "fontconfig"
    depends_on "freetype"
    depends_on "frei0r"
    depends_on "gnutls"
    depends_on "lame"
    depends_on "libass"
    depends_on "libbluray"
    depends_on "libsoxr"
    depends_on "libvorbis"
    depends_on "libvpx"
    depends_on "opencore-amr"
    depends_on "openjpeg"
    depends_on "opus"
    depends_on "rtmpdump"
    depends_on "rubberband"
    depends_on "sdl2"
    depends_on "snappy"
    depends_on "speex"
    depends_on "tesseract"
    depends_on "theora"
    depends_on "x264"
    depends_on "x265"
    depends_on "xvid"
    depends_on "xz"
  
    def install
      args = %W[
        --prefix=#{prefix}
        --enable-shared
        --enable-pthreads
        --enable-version3
        --enable-avresample
        --cc=#{ENV.cc}
        --host-cflags=#{ENV.cflags}
        --host-ldflags=#{ENV.ldflags}
        --enable-ffplay
        --enable-gnutls
        --enable-gpl
        --enable-libaom
        --enable-libbluray
        --enable-libmp3lame
        --enable-libopus
        --enable-librubberband
        --enable-libsnappy
        --enable-libtesseract
        --enable-libtheora
        --enable-libvorbis
        --enable-libvpx
        --enable-libx264
        --enable-libx265
        --enable-libxvid
        --enable-lzma
        --enable-libfontconfig
        --enable-libfreetype
        --enable-frei0r
        --enable-libass
        --enable-libopencore-amrnb
        --enable-libopencore-amrwb
        --enable-libopenjpeg
        --enable-librtmp
        --enable-libspeex
        --enable-videotoolbox
        --disable-libjack
        --disable-indev=jack
        --enable-libaom
        --enable-libsoxr
      ]
  
      system "./configure", *args
      system "make", "install"
  
      # Build and install additional FFmpeg tools
      system "make", "alltools"
      bin.install Dir["tools/*"].select { |f| File.executable? f }
    end
  
    test do
      # Create an example mp4 file
      mp4out = testpath/"video.mp4"
      system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
      assert_predicate mp4out, :exist?
    end
  end
