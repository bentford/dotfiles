# dotfiles

My dotfiles organized by package and deployed with GNU `stow`.

## Using Stow

Use `stow` to install dotfiles you want:

```sh
stow git
stow zsh
stow nvim
```

- Always run stow from the root of your dotfiles repo.
- To stow everything `stow */`
- To unstow: `stow -D bash`
