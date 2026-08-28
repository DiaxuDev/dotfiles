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
    rev = "0cdfc32969e38ccaef08758d86006362e6eb93dc";
    hash = "sha256-Zv1WSYsdqVoEhXXtYA2U3tJnJVLFQ/af8rU6IM4Q2sI=";
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
