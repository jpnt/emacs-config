# emacs-config

This is my personal Emacs configuration, optimized for my workflow and preferences.
It is not meant to be a general-purpose configuration, but rather one that emphasizes
simplicity, speed, and minimalism while using the latest Emacs features.

Key features:

- **Fast startup**: Using early-init.el and streamlining the package setup.
- **e(vi)l mode**: For vi/vim-style keybindings.
- **Minimal plugins**: To keep the setup lightweight and maintainable over the years.
- **No org-mode**: I don’t like it.

```sh
git clone https://github.com/jpnt/emacs-config ~/.emacs.d --depth=1
```

## Goals

- **Minimal Configuration**: Less is more. Less configuration == better.
- **Ease of Modification**: The `init.el` should be easy to understand and modify,
  even for those unfamiliar with Emacs Lisp.
- **Fast and Lightweight**: Emacs should run efficiently on (almost) any machine. Fast startup time.
- **Streamlined Workflow**: Reduce friction, allowing for fast operations without
  plugins or configurations getting in the way.
- **Basic IDE Features**: Includes Git integration (`magit`), file explorer (`dired`),
  auto-completion (`company`), and language server protocol (via `eglot`).

## Installation of emacs from source

This configuration is designed to work with the lastest version of Emacs with some flags enabled so
building from source is recommended.

### Required Emacs Version

This configuration (Sep 19 2024) is built for Emacs v31 and newer.

### Cloning the Emacs Repository

```sh
git clone --branch=master git://git.sv.gnu.org/emacs.git
```

### Configuring Emacs

#### For X11

To configure Emacs for a X11 environment:

```sh
./configure --with-json --with-libgccjit --with-xpm=ifavailable --with-gif=ifavailable
````

#### For Wayland

To configure Emacs for a Wayland environment:

```sh
./configure --with-json --with-libgccjit --with-pgtk
```

#### Compile & Install

```sh
make -j$(proc) && sudo make install
```
