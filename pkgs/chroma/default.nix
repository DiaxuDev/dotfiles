{
  lib,
  stdenv,
  wayland,
  wayland-protocols,
  wayland-scanner,
  pkg-config,
  fetchgit,
}:
stdenv.mkDerivation {
  pname = "chroma";
  version = "2.0.0";

  src = fetchgit {
    url = "https://git.notashelf.dev/notashelf/chroma.git";
    rev = "889bd0a44f903c6418e76cd5ca860a1c1b928819";
    hash = "sha256-fV0Io6DgO6A+UxN67nr2gMFAjJ3ejEjr0hReVuVhHLo=";
  };

  patches = [
    ./001-fix-hang.patch
    ./002-correct-error.patch
    ./003-add-get.patch
    ./004-fix-make.patch
    ./005-fix-double-memset.patch
    ./006-fix-use-slots.patch
    ./007-canonicalize_paths.patch
  ];

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    wayland.dev
    wayland-protocols
  ];

  makeFlags = [
    "PREFIX=$(out)"
    "SYSTEMD_INSTALL=$(out)/share/systemd/user"
  ];

  doCheck = true;

  meta = {
    description = "Super-fast, lightweight and efficient wallpaper daemon for Wayland compositors";
    license = lib.licenses.mpl20;
    mainProgram = "chroma";
    platforms = lib.platforms.linux;
  };
}
