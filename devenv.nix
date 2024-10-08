{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.bundler
    pkgs.git
    pkgs.gitleaks
    pkgs.rubyPackages.solargraph
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
    ${pkgs.bundler}/bin/bundle install
  '';

  # https://devenv.sh/languages/
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;
  pre-commit.hooks = {
    gitleaks = {
      enable = true;
      # https://github.com/gitleaks/gitleaks/blob/8de8938ad425d11edb0986c38890116525a36035/.pre-commit-hooks.yaml#L4C10-L4C54
      entry = "${pkgs.gitleaks}/bin/gitleaks protect --verbose --redact --staged";
    };
    nixpkgs-fmt.enable = true;
    prettier.enable = true;
    rubocop = {
      enable = true;
      # https://github.com/rubocop/rubocop/blob/d67dd0334edeec9ca9d9ac1d625b8da2d46e622a/.pre-commit-hooks.yaml
      entry = "${pkgs.rubyPackages.rubocop}/bin/rubocop --autocorrect --force-exclusion";
      types = [ "ruby" ];
    };
    # https://github.com/cachix/pre-commit-hooks.nix/issues/31#issuecomment-744657870
    trailing-whitespace = {
      enable = true;
      # https://github.com/pre-commit/pre-commit-hooks/blob/4b863f127224b6d92a88ada20d28a4878bf4535d/.pre-commit-hooks.yaml#L201-L207
      entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/trailing-whitespace-fixer";
      types = [ "text" ];
    };
  };

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
