# <a href="https://github.com/dmarcoux/dismoi">dmarcoux/dismoi</a>

## Development Environment with nix-shell

Reproducible development environment which relies on
[Nix](https://github.com/NixOS/nix), a purely functional and cross-platform
package manager.

### Usage

1. Start with `nix-shell --pure`
2. Run `mix setup` to install and setup dependencies
3. Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
4. Visit [`localhost:4000`](http://localhost:4000) from your browser.

## Continuous Integration with [GitHub Actions](https://docs.github.com/en/actions)

Linters, tests and more. Details under [.github/workflows](./.github/workflows).

## [Dependabot](https://dependabot.com/)

Automated dependency updates. Details in the [config](./.github/dependabot.yml).

## Production & Continuous Delivery

The first deployment was done with `flyctl launch`, then the following ones with
the [continuous delivery](./.github/workflows/continuous-delivery.yml) whenever
code is pushed to the `main` branch.

The secret `FLY_API_TOKEN` was created under the
[settings](https://github.com/dmarcoux/dismoi/settings/secrets/actions) of this
GitHub repository and it contains the output of `flyctl auth token`.
