---@param freeze? boolean
---@param screenshot_dir? string
---@return HL.Dispatcher
function Screenshot(freeze, screenshot_dir)
    env_vars = {
        FREEZE = freeze == nil and false or freeze,
        SCREENSHOT_DIR = screenshot_dir
    }
    local cmd = "bash ~/.config/hypr/scripts/screenshot.sh"
    for k, v in pairs(env_vars) do
        if v == nil then
            goto continue
        end
        cmd = k .. "=" .. tostring(v) .. " " .. cmd
        ::continue::
    end
    return hl.dsp.exec_cmd(cmd)
end
