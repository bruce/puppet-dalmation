define dalmation::dotfiles($source = $title, $dir = undef) {
  include boxen::config

  $repo_dir = $dir ? {
    undef   => "/Users/${::boxen_user}/.dotfiles",
    default => $dir
  }

  repository { $repo_dir:
    source => $source
  }

  ->

  file { "${repo_dir}/.gitignore":
    ensure => present
  }

  ->

  file_line { "gitignore ${repo_dir} .install.rb":
    path  => "${repo_dir}/.gitignore",
    line  => '/.install.rb',
    match => '/.install.rb.*'
  }

  ->

  file { "${repo_dir}/.install.rb":
    mode    => "0755",
    source  => "puppet:///modules/dalmation/install.rb"
  }

  ->

  exec { "install dalmation ${repo_dir}":
    cwd     => $repo_dir,
    command => "${repo_dir}/.install.rb"
  }

}
