local config = require("config")
local colors = require("colors")

local logger = {}

logger.LogLevel = {
    Error = 0,
    Warn = 1,
    Info = 2,
    Debug = 3
}

logger.logLevel = logger.LogLevel.Info

logger.callbacks = {
    Error = function(message)
        io.stderr:write(colors(message, "red") .. "\n")
    end,

    Warn = function(message)
        print(colors(message, "yellow"))
    end,

    Info = function(message)
        print(colors(message, "magenta"))
    end,

    Debug = function(message)
        print(colors(message, "grey"))
    end
}

local function emit(level, colorName, ...)
    if logger.logLevel < logger.LogLevel[level] then
        return
    end

    local message = table.concat({ ... }, " ")
    local prefix = config.NameUpper .. ": "

    logger.callbacks[level](prefix .. message)
end

function logger:debug(...)
    emit("Debug", "grey", ...)
end

function logger:info(...)
    emit("Info", "magenta", ...)
end

logger.log = logger.info

function logger:warn(...)
    emit("Warn", "yellow", ...)
end

function logger:error(...)
    local message = table.concat({ ... }, " ")
    emit("Error", "red", message)
    error(config.NameUpper .. ": " .. message, 2)
end

return logger
