# Saas You Later

Saas You Later (SYL) is a startup focused profitability and business model
calculator. This is a reimplementation of original Saas You Later using
SvelteKit.

Visit [Saas You Later here](https://www.saasyoulater.com)

## Requirements

You need to have the following on your machine to be able to develop SYL:

- Node v18 or later

Optional, but helpful

- An editor that supports [.editorconfig](https://editorconfig.org/) and
  [Language Server
  Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol)

## Developing

Provided that above requirements are fulfilled, you can install the
dependencies using

```bash
npm ci
```

and run the development server using

```
npm run dev
```

You can then open SYL in your browser at
[http://localhost:3000](http://localhost:3000).

## Testing

To test locally, install the headless Firefox that
[Playwright](https://playwright.dev/) uses by running

```
npm run check:playwright:install
```

You might want to use a desktop firewall like
[OpenSnitch](https://github.com/evilsocket/opensnitch) to stop Firefox from
phoning home to their location service or getpocket.com.

To test everything then, run

```
npm test
```

This will

- prettify,
- lint,
- check types,
- run unit tests, and
- run playwright e2e tests.

## Building

To build SYL, run

```bash
npm run build
```

The production build can be previewed using

```bash
npm run preview
```

## Deployment

TODO write me
