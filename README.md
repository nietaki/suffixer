# Suffixer

An example project showcasing [hoplon](https://github.com/nietaki/hoplon) - 
the tool that helps you verify that the hex.pm packages you use don't contain
any extra code apart from what's in their Github repositories.

When run, the application runs a webserver that returns words that end in a 
given suffix. Here's an example deployed to Heroku: https://suffixer.herokuapp.com/s/ix

For aligning the words it uses [evil\_left\_pad](https://github.com/nietaki/evil_left_pad/),
which is a package that contains some potentially malicious code that's not present
on its github, but will be in suffixer's `deps/` directory. It's an example of a
malicious package.

It also contains [hoplon](https://github.com/nietaki/hoplon), which is the tool

# Using Hoplon tasks

When you compile the project using `$ mix compile` you'll have access to hoplon mix
tasks:

    $ mix help | grep hoplon
    mix hoplon.absolve           # marks the package as OK, even if it differs from source or can't be resolved
    mix hoplon.check             # Checks project's dependencies for hidden code
    mix hoplon.diff              # Shows differences between pulled package dependency and its github code
    mix hoplon.release_checklist # Prints a checklist for releasing hoplon-compatible packages and its completion status

Running `$ mix hoplon.check` should print something like the following, with the `HONEST`
and `ABSOLVED` rows coloured green and the `CORRUPT` coloured red:

    Dependency  Version  Github  LocatedBy  Status
    ace  0.16.0  crowdhailer/ace  tag:0.16.0  HONEST
    cookie  0.1.0  CrowdHailer/cookie.ex  tag:0.1.0  HONEST
    evil_left_pad  0.3.0  nietaki/evil_left_pad  bisect:433ccc5172094e174e7a816274dd588cb3993022  CORRUPT: [files_differ: "/lib/evil_left_pad.ex"]
    hoplon  0.3.2  nietaki/hoplon  tag:v0.3.2  HONEST
    mime  1.2.0  elixir-lang/mime  tag:v1.2.0  ABSOLVED: 78adaa84832b3680de06f88f0997e3ead3b451a440d183d688085be2d709b534 - "just formatting changes"
    plug  1.5.0  elixir-plug/plug  tag:v1.5.0  HONEST
    raxx  0.15.0  crowdhailer/raxx  tag:0.15.0  HONEST
    uuid  1.1.8  zyro/elixir-uuid  tag:v1.1.8  HONEST
    
This shows you the dependencies in your project and if their contents line up
with what they show on Github. You can see `evil_left_pad` is marked as 
`CORRUPT` (and for a good reason too).

To see the extra code in `evil_left_pad`, run `$ mix hoplon.diff evil_left_pad` - 
it will output a diff between the deps directory and the cloned repository directory.

You might notice that the `mime` package (depended on by `plug`) is marked as `ABSOLVED`.
That's because after looking at its diff, one of the developers of suffixer decided the 
differences were innocent and harmless and absolved it using `$ mix hoplon.absolve`.

