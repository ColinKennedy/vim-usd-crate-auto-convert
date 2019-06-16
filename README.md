vim-usd-create-auto-convert convert Pixar's USD binary format into ASCII
and then writes back to binary, all within a single Vim session. With
vim-usd-create-auto-convert, you can edit, write, and save crate files
as if they were ASCII and the plugin handles all the conversions for
you.


## Demo
[![asciicast](https://asciinema.org/a/251912.svg)](https://asciinema.org/a/251912)


## Installation
Use your plugin manager to add this plugin to Vim.

### vim-plug
```vim
Plug 'ColinKennedy/vim-usd-crate-auto-convert'
```

### Vundle
```vim
Plugin 'ColinKennedy/vim-usd-crate-auto-convert'
```


## Requirements
- Must have USD compiled
- `usdcat` (or another equivalent executable) command must be available
in your PATH environment variable. `usdcat` is used to convert to and
from binary.

## Options

|     Variable     |                                 Description                                 | Default  |
|------------------|-----------------------------------------------------------------------------|----------|
| g:usdcat_command | The executable that will be used to convert to and from USD crate (binary)  | "usdcat" |
