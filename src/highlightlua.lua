local Tokenizer = require("limitless.tokenizer")
local util = require("limitless.util")
local colors = require("colors")

local TokenKind = Tokenizer.TokenKind
local lookupify = util.lookupify

local NON_COLORED_SYMBOLS = lookupify({
    ",", ";", "(", ")", "{", "}", ".", ":", "[", "]"
})

local DEFAULT_GLOBALS = lookupify({
    "string",
    "table",
    "bit",
    "bit32"
})

return function(code, luaVersion)
    local tokenizer = Tokenizer:new({
        LuaVersion = luaVersion
    })

    tokenizer:append(code)

    local tokens = tokenizer:scanAll()
    local output = {}
    local position = 1

    for _, token in ipairs(tokens) do
        if token.startPos >= position then
            output[#output + 1] = code:sub(position, token.startPos)
        end

        local text = token.source

        if token.kind == TokenKind.Ident then
            if DEFAULT_GLOBALS[text] then
                output[#output + 1] = colors(text, "red")
            else
                output[#output + 1] = text
            end

        elseif token.kind == TokenKind.Keyword then
            output[#output + 1] = colors(text, "yellow")

        elseif token.kind == TokenKind.Symbol then
            if NON_COLORED_SYMBOLS[text] then
                output[#output + 1] = text
            else
                output[#output + 1] = colors(text, "yellow")
            end

        elseif token.kind == TokenKind.String then
            output[#output + 1] = colors(text, "green")

        elseif token.kind == TokenKind.Number then
            output[#output + 1] = colors(text, "red")

        else
            output[#output + 1] = text
        end

        position = token.endPos + 1
    end

    if position <= #code then
        output[#output + 1] = code:sub(position)
    end

    return table.concat(output)
end
