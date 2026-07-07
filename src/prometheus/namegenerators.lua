local generators = {
    Mangled = require("Prometheus.namegenerators.mangled"),
    MangledShuffled = require("Prometheus.namegenerators.mangled_shuffled"),
    Il = require("Prometheus.namegenerators.Il"),
    Number = require("Prometheus.namegenerators.number"),
    Confuse = require("Prometheus.namegenerators.confuse")
}

function generators.get(name)
    return generators[name]
end

function generators.exists(name)
    return generators[name] ~= nil
end

function generators.list()
    local list = {}

    for name, generator in pairs(generators) do
        if type(generator) ~= "function" then
            list[#list + 1] = name
        end
    end

    table.sort(list)

    return list
end

return generators
