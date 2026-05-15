---@return boolean
function HasTouchpad()
    local f = io.open("/proc/bus/input/devices", "r")
    if not f then return false end
    local content = f:read("*a")
    f:close()
    return content:lower():find("touchpad") ~= nil
end
