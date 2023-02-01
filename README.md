# <a href="https://github.com/dmarcoux/dismoi">dmarcoux/dismoi</a>

A personal dashboard for all information I need.

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

### Secrets

The secret `FLY_API_TOKEN` was created under the
[settings](https://github.com/dmarcoux/dismoi/settings/secrets/actions) of this
GitHub repository and it contains the output of `flyctl auth token`.

### DNS

The DNS settings are on Cloudflare.

A and AAAA records with the name `dismoi` were created on my domain for the IP
addresses listed by `flyctl ips list`. Those records are proxied, so there must
also be a CNAME record for the certificate to be correctly issued. This CNAME
record was created with the name `_acme-challenge.dismoi` and its value is
displayed on the certificates page of my [Fly.io
dashboard](https://fly.io/apps/dismoi/certificates/dismoi.dmarcoux.com).

Make sure that the SSL/TLS encryption mode is _Full_, this can be done under the
SSL/TLS settings of my domain in the Cloudflare UI. This is needed to prevent
HTTP 520 errors.

### Persistent Volume for SQLite3 Database

On Fly.io, SQLite3 databases must be stored on [persistent
volumes](https://fly.io/docs/elixir/advanced-guides/sqlite3/) to not be
overwritten whenever a new deployment occurs.

Create a persistent volume with:

```bash
# dismoi is the name of the volume
fly volumes create dismoi
```
