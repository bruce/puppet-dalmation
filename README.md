# puppet-dalmation

Simple dotfile installation with Boxen.

## Required Puppet Dependencies

 * boxen
 * stdlib

## Example

In your personal manifest, the following will install a directory of
dotfiles at `http://github.com/username/reponame` at `$HOME/.dotfiles`:

```puppet
dalmation::dotfiles { "username/reponame": }
```

You can change the directory by passing a `dir` option:

```puppet
dalmation::dotfiles { "username/reponame":
  dir => "/my/installation/location"
}
```

Once your dotfiles are checked out, they will be installed via
symlinking to the locations you define.

## How to package dotfiles

Create files or directories, and accompany them with files alongside
with an additional `.symlink` extension. The contents of the file
should contain the target location of the symlink.

It can contain `$HOME`.

## Restrictions

Note that symlink definitions pointing to non-existing directories
will fail gracefully with STDERR logging.

Boxen will drop the installation script at `.install.rb` (and add it
to `.gitignore`). You can manually run it and see any failed installations.
