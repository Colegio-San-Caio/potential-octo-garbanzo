<div align="center">

<img src="https://static.ietf.org/logos/icon-rfceditor.svg" alt="RFC Editor" height="125" />

# RFC Editor Website

[![Release](https://img.shields.io/github/release/ietf-tools/red.svg?style=flat&maxAge=300)](https://github.com/ietf-tools/red/releases)
[![License](https://img.shields.io/github/license/ietf-tools/red)](https://github.com/ietf-tools/red/blob/main/LICENSE)
![Node Version](https://img.shields.io/badge/node.js-24-green?logo=node.js&logoColor=white)
![Nuxt Version](https://img.shields.io/badge/nuxt-4-green?logo=nuxt.js&logoColor=white)
![Vue Version](https://img.shields.io/badge/vue-3-green?logo=vue.js&logoColor=white)

##### Website for the RFC Editor (Codename: RED)

</div>

# Design

- The [new www.rfc-editor.org design on Figma](https://www.figma.com/design/bCDqtdSnErGOe6Oc87W8pR/RFC-Editor---Design-2). As development continues this is the graphic design that we will be adhering to where possible.

# Contributing

This code repository is under the broader guidance from [IETF CONTRIBUTING.md](https://github.com/ietf-tools/.github/blob/main/CONTRIBUTING.md).

# Development

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) _(Windows only)_

## Getting Started

### Website

See `/website/`.

It's a Nuxt website ([official Nuxt documentation](https://nuxt.com/docs/getting-started/introduction)).

#### Website content (markdown)

Website content from markdown files can be found in `/website/content/`.

Markdown Frontmatter (metadata) fields supported are listed in [content.config.js](https://github.com/ietf-tools/red/blob/main/website/content.config.ts#L8).

The 'last updated' footer on markdown pages is computed from Git log's commit time.
It is manually synced by a developer by running (from within `website/`) the command `npm run generate:content-metadata`.
This will update `generated/content-metadata.json` and that file should be committed.

A website deploy isn't involved in updating content. The website downloads markdown content precomputed into JSON, so the precomputer is mostly involved in deploying content changes. Once markdown changes are merged and pushed to GitHub the 'Precomputer Docker Image' must be rebuilt and then, in Tekton, run 'precompute-single' with any RFC to regenerate all website content.

#### Website testing

In `/website/` run `npm run test`. This runs unit tests, type checking, and linting. E2E tests must be run separately with `npm run test:e2e`.

#### Website APIs

The website depends on APIs in the form of:

- Search (via Typesense, managed outside of this repository)
- Precomputed API responses (managed in this repository, in `/precomputer/`)

### Precomputed API responses

See `/precomputer/`.

We precompute the result of many APIs used by the website and upload them to an S3-like bucket.

This is done for performance reasons (some these APIs can take minutes to compute) and it improves resilience.

The `/precomputer/` code is intentionally separate from the website/Nuxt. It has its own `package.json` etc.

The entry point for the precomputer is `precomputer/src` with the items `single.ts`, `all.ts`, `multiple.ts`, and `cron.ts`:

- `single.ts` calculates a single RFC 'info' page API data and RFC-specific APIs such as `/rfc/rfcN.json`.
- `all.ts` does the same with ranges of RFCs. 
- `multiple.ts` handles a comma-separated list of RFC numbers.
  - `multiple.ts --skip-indices` rebuilds only the per-RFC files. 
- `cron.ts` handles indices (all subseries, RFC indexes like on the homepage that list all RFCs, RSS/Atom feeds, etc.). As the name `cron.ts` implies this script is run periodically.

### Redirects

Redirects live in sevearl places. They are listed here from highest to lowest server cost, so prefer the lowest-cost option that can do the job:

* **Nuxt redirects:** highest cost, so use sparingly. Best for trivial URL normalization (adding a trailing slash, fixing casing, removing leading zeros) where it's tidier to keep the redirect next to the code that defines the canonical URL.
* **Cloudflare worker redirects:** medium cost. These are in `/worker/` and run as JavaScript at the edge, without Nuxt's overhead. This is the default place for most redirects.
* **Cloudflare redirect rules:** This has the ability to configure complex regex rules.
* **Cloudflare bulk redirects:** lowest cost, but limited in what they can express.

#### Precomputer tests

In `/precomputer/` run `npm run test`.

## Troubleshooting

### During local dev website doesn't update with changes

Stop the dev server, run `npm run cleanup`, and restart the dev server

## KDP profile mains (Lex, Yacc, RPC, file systems)

Each one prints the same four lines: nickname, code, role, points.

| Where | What | Build / run |
|---|---|---|
| `lex/main.l` | Lex (flex) scanner | `flex -o main.yy.c lex/main.l && cc -o kdp_lex main.yy.c && ./kdp_lex` |
| `yacc/main.y` | Yacc (bison) grammar | `cd yacc && bison -o main.tab.c main.y && cc -I. -o kdp_yacc main.tab.c && ./kdp_yacc` |
| `rpc/main.x` | rpcgen interface | `cd rpc && rpcgen -h main.x -o main.h && rpcgen -c main.x -o main_xdr.c && gcc -I/usr/include/tirpc kdp_main.c main_xdr.c -ltirpc -o kdp_xdr && ./kdp_xdr` |
| `fs/main.ext4`, `fs/main.fat32` | real ext4 and FAT32 images | `sh fs/main.ext4`, `python3 fs/main.fat32` |
| `fs/main.exfat`, `main.ntfs`, `main.hfsplus`, `main.apfs`, `main.smb`, `main.nfs` | need extra tools or macOS, or are config files | see the comment at the top of each file |
