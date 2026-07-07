local function scriptPath()
    local source = debug.getinfo(2, "S").source:sub(2)
    return source:match("(.*[/%\\])")
end

local previousPackagePath = package.path
package.path = ("%s?.lua;%s"):format(scriptPath(), previousPackagePath)

do
    local ok = pcall(function()
        return math.random(1, 2 ^ 40)
    end)

    if not ok then
        local random = math.random

        math.random = function(min, max)
            if min == nil and max == nil then
                return random()
            end

            if max == nil then
                return math.random(1, min)
            end

            if min > max then
                min, max = max, min
            end

            local range = max - min

            if range > 2147483647 then
                return math.floor(random() * range + min)
            end

            return random(min, max)
        end
    end
end

if not _G.newproxy then
    function _G.newproxy(meta)
        if meta then
            return setmetatable({}, {})
        end

        return {}
    end
end

local modules = {
    Pipeline = require("limitless.pipeline"),
    Util = require("limitless.util"),
    Logger = require("logger"),
    Colors = require("colors"),
    Highlight = require("highlightlua"),
    Presets = require("presets"),
    Config = require("config")
}

package.path = previousPackagePath

local api = {
    Name = "Limitless",
    Version = "0.1.0",
    Pipeline = modules.Pipeline,
    Logger = modules.Logger,
    Colors = modules.Colors,
    Highlight = modules.Highlight,
    Presets = modules.Presets,
    Config = modules.Util.readonly(modules.Config)
}

return setmetatable(api, {
    __metatable = "Locked",
    __newindex = function()
        error("Attempt to modify a readonly Limitless API.", 2)
    end
})
