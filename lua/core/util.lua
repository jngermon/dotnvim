local util = {}

function util.dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. util.dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function util.cleanTable(t)
    local cleanTable = {}
    for _, v in pairs(t) do
        if v ~= nil then
            table.insert(cleanTable, v)
        end
    end
    return cleanTable
end

return util
