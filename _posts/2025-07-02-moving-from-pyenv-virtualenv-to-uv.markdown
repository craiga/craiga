---
title: Moving from pyenv-virtualenv to uv
date: 2025-07-02 16:00:00 +0100
---

For a long time now, I’ve had a nice thing going with [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv). I’ve been using a script like the following to get a virtual environment up and running:

```
pyenv install --skip-existing 3.13.5
pyenv virtualenv 3.13.5 my-cool-proj
echo "my-cool-proj" > .python-version
```

This causes pyenv to use its shim magic to switch to the `my-cool-proj` virtual environment when I `cd` into my project’s directories.

Unfortunately, this conflicts with an emerging community standard where tools are expecting `.python-version` to contain the version of Python this project makes use of. Heroku, for example, [have marked their `runtime.txt` file as deprecated](https://devcenter.heroku.com/changelog-items/3141) and [are now using `.python-version` to determine which version of Python to use](https://devcenter.heroku.com/articles/python-runtimes).

After a short period of moaning to myself about this, I’m now switching over to a workflow using [uv](https://docs.astral.sh/uv/) and a zsh function which seems to be working almost as well as the above.

[Once uv is installed](https://docs.astral.sh/uv/getting-started/installation/), creating a virtual environment with it is simple.

```
❯ uv venv --python 3.13.5

Using CPython 3.13.5 interpreter at: /opt/homebrew/opt/python@3.13/bin/python3.13
Creating virtual environment at: .venv
Activate with: source .venv/bin/activate
```

This creates a virtual environment in a `.venv` directory inside the project. Activate it like any other virtual environment:

```
❯ source .venv/bin/activate
```

This is fine, but I was missing having my virtual environment automatically activate. There are lot of solutions out there for to solve this problem. I found that adding this to my `.zshrc` file to be the most elegant and least intrusive (your mileage may vary):

```
# Adapted from https://andreamaglie.com/automatically-activate-python-virtual-environments-with-zsh

activate_venv() {
    local venv_dir=".venv"
    if [[ -d "$PWD/$venv_dir" ]]; then
        source "$PWD/$venv_dir/bin/activate"
    fi
}
 
autoload -U add-zsh-hook
add-zsh-hook chpwd activate_venv
activate_venv
```

## Warnings when creating virtual environment

On most of the projects I work on, running `uv venv` for the first time triggered a warning about a missing version field in `pyproject.toml`. I’ve been working around this by adding the following to `pyproject.toml`:

```
[project]
dynamic = ["version"]
```
