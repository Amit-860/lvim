# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# Custom Stuff start from here
$env.XDG_DATA_HOME = $env.APPDATA
$env.XDG_CONFIG_HOME = $env.LOCALAPPDATA
$env.XDG_CACHE_HOME = $env.TEMP

$env.LUNARVIM_RUNTIME_DIR = (($env.XDG_DATA_HOME | append '\lunarvim') | str join)
$env.LUNARVIM_CONFIG_DIR = (($env.XDG_CONFIG_HOME | append '\lvim') | str join)
$env.LUNARVIM_CACHE_DIR = (($env.XDG_CACHE_HOME | append '\lvim') | str join)
$env.LUNARVIM_BASE_DIR = (($env.LUNARVIM_RUNTIME_DIR | append '\lvim') | str join)
neovide --multigrid -- -u (($env.LUNARVIM_BASE_DIR | append '\init.lua') | str join)
