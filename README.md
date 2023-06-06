# Complete Verifiable Example of [rgeo/rgeo-proj4#39](https://github.com/rgeo/rgeo-proj4/issues/39)

You need to have proj installed for this to work (ex: `brew install proj`).

```bash
./run # reproduce the error
./run fix # reproduce a fix
```

The bug happens when we are forking process in Ruby and not using Proj4's
multithreaded API. I'm sure that we could pin the bug further, and I'd be
glad to know how if someone is doing it (buonomo.ulysse[at]gmail.com or a
comment).

## What's next

I didn't have rgeo-proj4 offline so I couldn't code a fix. We should use
the proper `proj_context*` API rather than using the default context. I
also tested further and it seems like having a local `static PJ_CONTEXT*`
in the C extension file, and set it in the `Init_extension` method should
be sufficient. Even if we fork afterward. But of course this would be
better with a test reproducing the bug (e.g. non-regression test).

## How did I get there

From [Pe-co's reproduction](https://github.com/Pe-co/rgeo_test_app) and using
ruby's [TracePoint](https://devdocs.io/ruby~3/tracepoint) API to know where
were all the `c_call`s where coming from. I could progressively remove parts
of the example to understand that nor RGeo nor Rails had anything to do with
it. And in the end, in the `proj4_create` function in the rgeo-proj4 project
I had to switch to C, ending with this example.
