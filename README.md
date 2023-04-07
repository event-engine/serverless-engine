<br />

<h1 align="center">Serverless Event Engine</h1>

✅ &nbsp;First-Class Typescript Support<br>
✅ &nbsp;Shared API Gateway<br>
✅ &nbsp;Environments Configuration<br>
✅ &nbsp;CORS<br>
✅ &nbsp;CQRS / Event Sourcing Tooling<br>
✅ &nbsp;prooph board Cody<br>
✅ &nbsp;Keycloak Auth<br>
✅ &nbsp;ESLint<br>
✅ &nbsp;Jest<br>
✅ &nbsp;Github Actions

<hr />

[![serverless](http://public.serverless.com/badges/v3.svg)](http://www.serverless.com)
[![](https://img.shields.io/badge/monorepo-Nx-blue)](https://nx.dev/)
![esbuild](https://badges.aleen42.com/src/esbuild.svg)
![npm peer dependency version (scoped)](https://img.shields.io/npm/dependency-version/eslint-config-prettier/peer/eslint)
![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/event-engine/serverless-engine/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/event-engine/serverless-engine)
![Maintained](https://img.shields.io/maintenance/yes/2023.svg)


## Prerequisites

- Docker
- Node.js 16


## Getting Started

- Run `git clone https://github.com/event-engine/serverless-engine my-project`
- Run `cd my-project`
- Run `cp .env.dist .env`
- Run `npm install`
- Run `npm install -g nx`
- Run `docker-compose up -d` ( Check that it works by going to http://localhost:8080/auth/admin, login: dev:dev)
- Run `nx preparedb core`
- Update the `environment` files based on your configuration
- Run `npm run serve`

## About the Repo

The repository is meant to be used as a project template. Once cloned, it's yours! Change git remote origin and push to your own upstream.

The template is work in progress. We'll move most of the libs into dedicated npm packages as soon as they are stable.
So you'll be able to install them later through npm and receive updates. Meanwhile, you can keep a reference to this upstream and pull in 
changes. Please be aware that if you modify files shipped with the template, you have to resolve merge conflicts yourself.

```

## Commands

```bash
nx serve <service-name>
nx deploy <service-name>
nx remove <service-name>
nx build <service-name>
nx lint <service-name>
nx test <service-name>

// Use different enviroment
NODE_ENV=prod nx deploy <service-name>
NODE_ENV=stg nx deploy <service-name>

// Run only affected
nx affected:test
nx affected:deploy
```

## Generators

```bash
// Generate a service
npm run g:service MyService

// Generate an aggregate
npm run g:aggregate MyService MyAggregate ArId

// Generate a command
npm run g:command MyService MyAggregate MyCommand

// Generate an internal/aggregate event
npm run g:event MyService MyAggregate MyEvent

// Generate a public event produced by a service
npm run g:produce-event MyService MyEvent

// Generate a public event consumed by a service
npm run g:consume-event ConsumingService ProducingService MyEvent

// Generate a query
npm run g:query MyService MyQuery Namespaced/ReturnType

// Generate a value object
npm run g:vo MyService MyValueObject /MyNamespace

// Generate a process manager aka event listener
npm run g:process-manager MyService MyProcessManager SomeService.SomeEvent
```

<hr />

## Keycloak

Login to [Keycloak Admin Console](http://localhost:8080/auth/admin) with

user: dev
pwd: dev

## Event Map

@TODO: Link architecture overview

## prooph board Cody

Start the local Cody server with:

`npm run cody`

The server listens on the default Cody port `3311`.

How to connect from prooph board to the local Cody server is explained in the [prooph board wiki](https://wiki.prooph-board.com/cody/nodejs-cody-tutorial.html#start-cody-server)

The Cody implementation used here is specifically designed to make use of the `Nx Generators` listed above.
For example when triggering Cody with a command, Cody will take the command information (name, linked aggregate, command metadata),
normalize it and pass it to the `g:command` nx generator.

*please note: it takes a moment to spin up the generator in the background so give Cody a moment to respond.*

Detailed information about working with Cody on the Event Map can be found in the [wiki](https://wiki.prooph-board.com/cody/nodejs-cody-tutorial.html#modeling-on-event-map)

*@TODO: A step by step guide for all available generators (and Cody hooks) is WIP*

[Card Metadata Templates](https://wiki.prooph-board.com/board_workspace/Metadata.html#card-metadata-templates) are available
so that all necessary metadata properties are prefilled for the card types.

Import [prooph-board-metadata-templates.json](/prooph-board-metadata-templates.json) in your prooph board for this project.

## CI/CD Pipeline with Github Actions

The pipeline has been configured to run everytime a push/pull_request is made to the `main` branch. You should uncomment the `deploy-serverless.yml` workflow.

#### Workflow Steps

- Checkout: The `checkout` action is used to checkout the source code.

- Node setup: The `setup-node` action is used to optionally download and cache distribution of the requested Node.js version.

- lint and test: The `lint` and `test` runs only on affected projects.

- Configure AWS credentials: The credentials needed are `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and should be set as Github __secrets__.

- Each branch should be prefixed with the `environment` name. For example, if we have a `stg-feature-name` branch and open a pull request to the `main` branch, it will set `NODE_ENV` to `stg` and deploy to this environment.

By merging the pull request to the `main` branch, `NODE_ENV` is set to `prod`, and the deployment is done to production.

The workflow file can have as many environments as you need.

## Credits

> Based on "The Ultimate Monorepo Starter for Node.js Serverless Applications" (https://github.com/ngneat/nx-serverless.git)

## Powered by prooph software

[![prooph software](https://github.com/codeliner/php-ddd-cargo-sample/blob/master/docs/assets/prooph-software-logo.png)](http://prooph.de)

Event Engine is maintained by the [prooph software team](http://prooph-software.de/). The source code of Serverless Event Engine
is open source. Prooph software offers commercial support and workshops
for Serverless Event Engine and Event Storming on [prooph board](https://prooph-board.com/).

If you are interested please [get in touch](http://prooph.de)
