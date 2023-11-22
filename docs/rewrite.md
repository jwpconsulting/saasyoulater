# Rewriting saas you later (SYL)

## Current issues

### Elm is old

An old version of elm is used. If a newer version of elm is to be used, it can
not be installed with npm anymore. This makes building the project harder
and harder. The version of elm installed in package.json does not work with
arm64 on macOS.

### Elm is niche

The elm landing page won't load with js in the browser disabled. There isn't
even a little bit of prerendering. Elm has had a very controversial past with
issues including

- support for non-elm dependencies being unreliable
- the development of the language stagnating
- some maintainers of Elm or widely used packages having their own "approaches"
  to development and community interaction found by some to be less
  "agreeable".

### The implementation is overkill

At the time of writing, I count 1341 lines of Elm, to calculate some values in
a table (I'm exaggerating of course).

### New features not being implemented

No new features are being added, have been added in quite a while. This tool
has a lot of potential, and it's being wasted.

## Opportunities

### Simple is best

A frontend project should be buildable by just using npm.

### TypeScript has won

I was drawn to Elm because of the type safety. TypeScript solves that

### Reactive rendering is mainstream

React/etc. all have learned from Elm's FRP, and it's usable in some way
everywhere now.

### Prerendering has advanced a lot

Yes, there are many interactive bits, but having an empty page load is not
cool. SvelteKit has excellent prerendering support.

### Breathe new wind into the project

So, if we switch libraries, and language to something with TypeScript, we can
finally implement all the new things we have meant to.

### Learn some new things

Implementing some new features can always be helpful when trying to learn
something. SYL is finance related, so that's an area of development that the
author rarely interacts with.

### It's fun

Need I say more?

## Approach

Let's think about steps:

### Get the project to build somehow

Yes, unfortunately we have to find a way to get this to build. Perhaps we can
build this on an OS with a Linux kernel, there should still be a binary out
there on npm

### Get just the HTML skeleton

We want to aim for 100% compatiblity in a rewrite. We should extract the
generated HTML and put it into some svelte components

### Reimplement all the unit tests

The unity tests are our life line to make sure that the equations are all
correct.

### Go slow and reimplement one by one

Not complete, but one by one implement

- Layout
- Controls
- Table rendering
- Local storage interaction
- Tabs
- Help screen
- Results display

### Deploy

Get this to build and deploy on Netlify

### Test and compare results

Referencing the old version, compare and check that the new version gives
correct results

## Further steps

Now that we have reimplemented it

### Add i18n

This one is important. Mark all strings for translation and localize them to at
least German and Japanese

### Commission user testing

Go to a user testing online platform, ask some people to test SYL and get their
feedback.

### Make scenarios shareable by URL

This is super useful. A scenario should be shareable with a URL

### Allow capturing one time costs

Suggestion from a user

### Improve design

Design can always use some help

### Spread the word

Now that the tool works better and looks better, share it with some people that
might like it.

### Find more useful measures for startup modeling

Do some research, find more useful things. What are current business models out
there? What do people need? Is there a free software business angle we can have
for this?

### Generate PDF/CSV reports

This could be useful for sharing reports as files

## Tech stack

Use

- SvelteKit
- TypeScript
- Tailwind
- Jest
- Prettier
- Eslint with svelte, prettier and typescript support

## Testing

After implementing the previous math tests, we would also like to include some
SvelteKit end to end tests.

[This is a random link that I
found](https://dockyard.com/blog/2022/01/27/how-to-set-up-jest-in-a-sveltekit-app)
on using jest with SvelteKit
