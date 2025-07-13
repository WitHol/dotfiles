-- Tweaking the look of the terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Floating terminal under <C-j> 
Termbuf = nil
Termwin = nil
vim.keymap.set({'n', 'i', 'v', 't'}, '<C-t>', function()
  if Termwin and vim.api.nvim_win_is_valid(Termwin) then
    vim.api.nvim_win_close(Termwin, true)
    Termwin = nil
  else
    local openterm = false;

    if not Termbuf or not vim.api.nvim_buf_is_valid(Termbuf) then
      Termbuf = vim.api.nvim_create_buf(false, true)
      vim.bo[Termbuf].bufhidden = "hide"
      vim.bo[Termbuf].filetype = "terminal"
      openterm = true
    end

    local width = vim.o.columns;
    local height = vim.o.lines;
    Termwin = vim.api.nvim_open_win(Termbuf, true, {
      relative = 'editor',
      row = math.floor(height * 0.1),
      col = math.floor(width * 0.1),
      width = math.floor(width * 0.8),
      height = math.floor(height * 0.8),
      style = 'minimal',
      border = 'rounded'
    })

    vim.cmd("startinsert")
    if openterm then
      vim.fn.termopen(vim.o.shell)
    end
  end
end, { desc = "[T]erminal [W]indow" })
