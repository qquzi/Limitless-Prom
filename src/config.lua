local CONFIG = {
    Name = "Limitless",
    Revision = "Developer Preview",
    Version = "v1.0.0",
    Author = "kek",
    IdentifierPrefix = "__limitless_",
    Formatting = {
        Space = " ",
        Tab = "\t"
    }
}

CONFIG.NameUpper = CONFIG.Name:upper()
CONFIG.NameAndVersion = ("%s %s"):format(CONFIG.Name, CONFIG.Version)
CONFIG.FullName = ("%s %s %s"):format(
    CONFIG.Name,
    CONFIG.Revision,
    CONFIG.Version
)

if arg then
    for _, value in ipairs(arg) do
        if value == "--CI" then
            print(CONFIG.FullName:gsub("%s+", "-"))
        elseif value == "--FullVersion" then
            print(CONFIG.Version)
        elseif value == "--Version" then
            print(CONFIG.FullName)
        end
    end
end

return CONFIG
