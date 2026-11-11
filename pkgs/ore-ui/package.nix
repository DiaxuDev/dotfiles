{
  lib,
  stdenvNoCC,
  fetchFromGitHub,

  theme ? "dark",
  variant ? "emerald",
}:

assert lib.assertOneOf "theme" theme [
  "dark"
  "light"
];

assert lib.assertOneOf "variant" variant [
  "amethyst"
  "diamond"
  "emerald"
];

let
  themeName = "Ore UI - ${lib.toSentenceCase theme} ${lib.toSentenceCase variant}";
  iconThemeName = "Ore UI - Icon Pack";
in
stdenvNoCC.mkDerivation {
  pname = "ore-ui";
  version = "1.1-unstable-2026-09-18";

  src = fetchFromGitHub {
    owner = "ninsent";
    repo = "Ore-UI-theme-pack";
    rev = "0182e27d2d5e18b1ad46b282c3bb1f51b4183853";
    hash = "sha256-+t3a5JZDktqwiDOXh2U1BjT5rEJ+wbLFFjOMm2LRCOY=";
  };

  passthru = { inherit themeName iconThemeName; };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/PrismLauncher/iconthemes
    cp -r '${iconThemeName}' $out/share/PrismLauncher/iconthemes

    mkdir -p $out/share/PrismLauncher/themes
    cp -r '${themeName}' $out/share/PrismLauncher/themes

    find $out/share/PrismLauncher -type f \( -name '*.md' -o -name '*.license' -o -iname 'preview*' \) -delete

    runHook postInstall
  '';

  meta = {
    description = "Minecraft Bedrock inspired Ore UI theme for Prism Launcher";
    homepage = "https://github.com/ninsent/Ore-UI-theme-pack";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
