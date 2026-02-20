{
  stdenv,
  lib,
  buildGoModule,
  installShellFiles,
  fetchFromGitHub,
}:
buildGoModule (finalAttrs: {
  pname = "lyrecho";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "karol-broda";
    repo = "lyrecho";
    rev = "3e305c42dd469338c2ce30734379cc6530f22005";
    hash = "sha256-qATUzrJ3CxPXWUV5rzbnPe2iPogEOuMp+yKuL8cu8vA=";
  };

  vendorHash = "sha256-BiBIv02YIg66GtAnK6vZPMYOCRTU6NjpflAw4eSkoPA=";
  nativeBuildInputs = [ installShellFiles ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd lyrecho \
      --bash <($out/bin/lyrecho completion bash) \
      --fish <($out/bin/lyrecho completion fish) \
      --zsh <($out/bin/lyrecho completion zsh)
  '';

  meta = {
    description = "Terminal-based synchronized lyrics viewer for linux music players";
    homepage = "https://github.com/karol-broda/lyrecho";
    license = lib.licenses.unlicense;
    mainProgram = "lyrecho";
  };
})
