-- 注释
return {
  'numToStr/Comment.nvim',
  event = "VeryLazy",
  config = function()
    require('Comment').setup()
  end
}
