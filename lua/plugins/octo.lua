return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'echasnovski/mini.icons',
  },
  config = function ()
    require"octo".setup()
  end,
  cmd = "Octo",
}
