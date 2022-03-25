-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'
-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1
-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1
-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1
-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1
-- Allow commenting of my custom config files
vim.g.NERDCustomDelimiters = { configfile= { left= '#'}} 
