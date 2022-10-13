My neovim config. It is updated whenever I make a major change.

## Configuration comments for the future:
### sniprun
Run
```shell
./install
```
manually in the main plugin folder. This will generate the binary file in the correct place.

### tree-sitter
Install the packages `gxx_linux-64` and `gcc_linux-64` in your conda environment.

### LSP
#### Avoiding deprication warning
After configuring according to neovim for begginners blog (https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611), in file `lua/config/lsp/keymaps.lua` replace line 28 from
```lua
if client.resolved_capabilities.document_formatting then
```
to
```lua
if client.supports_method "textDocument/formatting" then
```

### Colorizer
After installing `colorizer`, the following error might appear:
```lua
Error detected while processing ~/.config/nvim/init.lua:
&termguicolors must be set
```
To fix, simply add
```lua
vim.opt.termguicolors = true
```
to `init.lua`.
