local interval = 1000.0 / 60.0

-- Internal state for smooth scrolling
local state = {
    impulse = 0.0,
    velocity = 0.0,
    delta = 0.0,
}

-- Timer handle (nil when not running)
local timer = nil

-- The tick function runs every interval and updates the scrolling state.
local function tick()
    local dt = interval / 1000.0 -- convert ms to seconds

    if math.abs(state.velocity) >= 1 or state.impulse ~= 0 then
        local vel = state.velocity
        local vel_sign = (vel == 0) and 0 or (vel / math.abs(vel))
        local friction = -vel_sign * 80
        local air_drag = -vel * 2.0
        local additional_force = friction + air_drag

        -- Update position delta and velocity
        state.delta = state.delta + state.velocity * dt

        local force_term = additional_force * dt
        if math.abs(force_term) > math.abs(state.velocity) then
            state.velocity = state.velocity + state.impulse - state.velocity
        else
            state.velocity = state.velocity + state.impulse + force_term
        end
        state.impulse = 0

        -- Convert the fractional delta to an integer scroll amount.
        local int_delta
        if state.delta >= 0 then
            int_delta = math.floor(state.delta)
        else
            int_delta = math.ceil(state.delta)
        end
        state.delta = state.delta - int_delta

        -- vim.notify("State: " .. tostring(state.velocity) .. " " .. tostring(state.delta) .. " " .. tostring(int_delta), vim.log.levels.WARN)
        -- Perform the scrolling using Neovim's normal command.
        if int_delta > 0 then
            vim.cmd(":execute \"normal! " .. tostring(math.abs(int_delta)) .. "\\<C-e>\"")
        elseif int_delta < 0 then
            vim.cmd(":execute \":normal! " .. tostring(math.abs(int_delta)) .. "\\<C-y>\"")
        end


        vim.cmd("redraw")
    else
        -- When scrolling slows down, stop the timer and reset state.
        state.velocity = 0
        state.delta = 0
        if timer then
            timer:stop()
            timer:close()
            timer = nil
        end
    end
end

local M = {}

function M.flick(impulse)
    -- This function is called to add an impulse for scrolling.
    -- It starts the timer if it is not already running.
    state.impulse = state.impulse + impulse
    if not timer then
        timer = vim.loop.new_timer()
        local flick_interval = math.floor(interval + 0.5)
        timer:start(flick_interval, flick_interval, vim.schedule_wrap(tick))
    end
end

vim.api.nvim_set_keymap("n", "<C-d>", ":lua require('comfortable_motion').flick(100)<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", ":lua require('comfortable_motion').flick(-100)<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":lua require('comfortable_motion').flick(200)<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":lua require('comfortable_motion').flick(-200)<CR>",
    { noremap = true, silent = true })

return M
