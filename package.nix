{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

let
  data = builtins.fromJSON (builtins.readFile ./version.json);
  system = stdenv.hostPlatform.system;

  asset =
    {
      x86_64-linux = "swls-linux-x86_64";
      aarch64-linux = "swls-linux-aarch64";
    }
    .${system} or (throw "swls: unsupported system ${system}");
in
stdenv.mkDerivation {
  pname = "swls";
  version = data.version;

  src = fetchurl {
    url = "https://github.com/SemanticWebLanguageServer/swls/releases/download/swls-v${data.version}/${asset}";
    hash = data.assets.${system};
  };

  dontUnpack = true;
  dontStrip = true;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  installPhase = ''
    runHook preInstall
    install -Dm755 "$src" "$out/bin/swls"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Semantic Web Language Server (Turtle, TriG, JSON-LD, SPARQL)";
    homepage = "https://github.com/SemanticWebLanguageServer/swls";
    license = licenses.mit;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    mainProgram = "swls";
  };
}
