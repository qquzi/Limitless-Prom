local COLORS = {
    reset = 0,
    bright = 1,
    dim = 2,
    underline = 4,
    blink = 5,
    reverse = 7,
    hidden = 8,

    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    grey = 37,
    gray = 37,

    pink = 91,
    white = 97,

    blackbg = 40,
    redbg = 41,
    greenbg = 42,
    yellowbg = 43,
    bluebg = 44,
    magentabg = 45,
    cyanbg = 46,
    greybg = 47,
    graybg = 47,
    whitebg = 107
}

local ESCAPE = "\27[%dm"

local settings = {
    enabled = true
}

local function ansi(code)
    return ESCAPE:format(code)
end

local function colorize(text, ...)
    text = tostring(text or "")

    if not settings.enabled then
        return text
    end

    local sequence = {}

    for i = 1, select("#", ...) do
        local name = select(i, ...)
        local code = COLORS[name]

        if code then
            sequence[#sequence + 1] = ansi(code)
        end
    end

    return ansi(COLORS.reset)
        .. table.concat(sequence)
        .. text
        .. ansi(COLORS.reset)
end

settings.codes = COLORS

return setmetatable(settings, {
    __call = function(_, ...)
        return colorize(...)
    end
})
