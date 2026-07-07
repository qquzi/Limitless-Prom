local defaults = {
    LuaVersion = "Lua51",
    VarNamePrefix = "",
    NameGenerator = "MangledShuffled",
    PrettyPrint = false,
    Seed = 0
}

local function preset(name, description, security, performance, steps)
    local cfg = {}

    for k, v in pairs(defaults) do
        cfg[k] = v
    end

    cfg.Name = name
    cfg.Description = description
    cfg.Security = security
    cfg.Performance = performance
    cfg.Steps = steps or {}

    return cfg
end

return {
    Fast = preset(
        "Fast",
        "Fast compilation with minimal runtime overhead.",
        1,
        5,
        {
            {
                Name = "ConstantArray",
                Settings = {
                    Threshold = 1,
                    StringsOnly = true
                }
            },
            {
                Name = "WrapInFunction",
                Settings = {}
            }
        }
    ),

    Balanced = preset(
        "Balanced",
        "Recommended for most scripts.",
        3,
        4,
        {
            {
                Name = "EncryptStrings",
                Settings = {}
            },
            {
                Name = "ConstantArray",
                Settings = {
                    Threshold = 1,
                    StringsOnly = true,
                    Shuffle = true,
                    Rotate = true,
                    LocalWrapperThreshold = 0
                }
            },
            {
                Name = "NumbersToExpressions",
                Settings = {}
            },
            {
                Name = "WrapInFunction",
                Settings = {}
            }
        }
    ),

    Secure = preset(
        "Secure",
        "High protection while maintaining good runtime performance.",
        4,
        3,
        {
            {
                Name = "EncryptStrings",
                Settings = {}
            },
            {
                Name = "AntiTamper",
                Settings = {
                    UseDebug = false
                }
            },
            {
                Name = "Vmify",
                Settings = {}
            },
            {
                Name = "ConstantArray",
                Settings = {
                    Threshold = 1,
                    StringsOnly = true,
                    Shuffle = true,
                    Rotate = true,
                    LocalWrapperThreshold = 0
                }
            },
            {
                Name = "NumbersToExpressions",
                Settings = {
                    NumberRepresentationMutation = true
                }
            },
            {
                Name = "WrapInFunction",
                Settings = {}
            }
        }
    ),

    Extreme = preset(
        "Extreme",
        "Maximum protection. Highest runtime overhead.",
        5,
        1,
        {
            {
                Name = "Vmify",
                Settings = {}
            },
            {
                Name = "EncryptStrings",
                Settings = {}
            },
            {
                Name = "AntiTamper",
                Settings = {
                    UseDebug = false
                }
            },
            {
                Name = "Vmify",
                Settings = {}
            },
            {
                Name = "ConstantArray",
                Settings = {
                    Threshold = 1,
                    StringsOnly = true,
                    Shuffle = true,
                    Rotate = true,
                    LocalWrapperThreshold = 0
                }
            },
            {
                Name = "NumbersToExpressions",
                Settings = {
                    NumberRepresentationMutation = true
                }
            },
            {
                Name = "WrapInFunction",
                Settings = {}
            }
        }
    ),

    VM = preset(
        "VM",
        "Virtualization benchmark preset.",
        5,
        2,
        {
            {
                Name = "Vmify",
                Settings = {}
            }
        }
    ),

    Custom = preset(
        "Custom",
        "Blank preset for custom pipelines.",
        0,
        5,
        {}
    )
}
