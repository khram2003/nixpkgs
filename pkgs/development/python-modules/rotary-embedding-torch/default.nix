{ lib
, buildPythonPackage
, fetchFromGitHub

# build-system
, setuptools
, wheel

# dependencies
, beartype
, einops
, torch
}:

buildPythonPackage rec {
  pname = "rotary-embedding-torch";
  version = "0.5.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lucidrains";
    repo = "rotary-embedding-torch";
    rev = "refs/tags/${version}";
    hash = "sha256-CCz/va5oydgU1JRDHKooRezbDbeGZHtD8Zy6fWJ2uRg=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    beartype
    einops
    torch
  ];

  pythonImportsCheck = [
    "rotary_embedding_torch"
  ];

  doCheck = false; # no tests

  meta = with lib; {
    description = "Implementation of Rotary Embeddings, from the Roformer paper, in Pytorch";
    homepage = "https://github.com/lucidrains/rotary-embedding-torch";
    changelog = "https://github.com/lucidrains/rotary-embedding-torch/releases/tag/${version}";
    license = licenses.mit;
    maintainers = teams.tts.members;
  };
}
