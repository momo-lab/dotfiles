require("config.lazy")

-- encodings
vim.opt.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932"

-- システムのクリップボードを使用
vim.opt.clipboard = "unnamedplus"
-- ステータス行
vim.opt.laststatus = 2
-- 行番号
vim.opt.number = true
-- undoをファイルに保存
vim.opt.undofile = true

-- 不可視文字
vim.opt.list = true
-- vim.opt.listchars = 'tab:▸ ,eol:↲,extends:❯,precedes:❮'
vim.opt.listchars = "tab: -,eol:↲,extends:>,precedes:<"

-- Keymapの調整
-- redoをUに割り当て
vim.keymap.set("n", "U", "<C-r>", { noremap = true })
-- vvで単語選択
vim.keymap.set("n", "vv", "viw", { noremap = true })
-- zzで畳み込みのトグル
vim.keymap.set("n", "zz", "za", { noremap = true })
-- qを押し間違えるので、マクロはQに変更
vim.keymap.set("n", "q", "<NOP>", { noremap = true })
vim.keymap.set("n", "Q", "q", { noremap = true })
-- ビジュアルモードのsはsurroundで使うのでSにremap
vim.keymap.set("x", "S", "s", { noremap = true })
vim.keymap.set("x", "s", "<NOP>", { noremap = true })
