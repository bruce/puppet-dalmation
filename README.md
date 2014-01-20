# puppet-dalmation

Simple dotfile installation with Boxen.

## Required Puppet Dependencies

 * boxen
 * stdlib

## Example

In your personal manifest, the following will install your set of
dotfiles from `http://github.com/username/reponame` to
`$HOME/.dotfiles`.
```puppet
dalmation::dotfiles { "username/reponame": }
```

You can change the directory by passing a `dir` option:

```puppet
dalmation::dotfiles { "username/reponame":
  dir => "/my/installation/location"
}
```

After pulling down the repo, it will symlink directories and
individual files you specify (see "How to package dotfiles," below).

WARNING: Please note that the symlink is created with `ln`'s "force"
option; any previously existing file in that location will be unlinked
first. Don't point your `.symlink` files at anything you care about
keeping.

## How to package dotfiles

Create files or directories, and accompany them with files alongside
with an additional `.symlink` extension. The contents of the file
should contain the target location of the symlink (and can contain `$HOME`).

For example, I maintain a
[personal set of configuration files for Emacs](https://github.com/bruce/dotfiles/tree/master/emacs),
that I store in my dotfiles repository as `emacs/personal`. I have
that directory configured in my
[.symlink](https://github.com/bruce/dotfiles/blob/master/emacs/personal.symlink)
to be symlinked to `~/.emacs.d/bruce`.

## Restrictions

Note that symlink definitions pointing to non-existing directories
will fail gracefully with STDERR logging.

Not all environment variables are available for expansion: only `$HOME` (and path
expansions like `~`) currently work.

## Debugging, running manually

Boxen will drop the installation script at `~/.dotfiles/.install.rb` (and add it
to `.gitignore`). You can manually run it and see any failed
installations.

## Contributing

Want to support additional ways of mapping symlinks? Want to expand
the types of path expansions and/or add conventions for dotfile
directory layout?

I'd love to see your issues -- and especially pull requests -- that we
can discuss.
