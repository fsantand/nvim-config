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
  keys = {
    {
      "<leader>op",
      "<cmd>Octo search is:open is:pr review-requested:fsantand -author:app/dependabot NOT Dockerfile<cr>",
      desc="Octo: View PRs review"
    }
  }
}
