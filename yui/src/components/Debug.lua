local Debug = {}
Debug.__index = Debug

function Debug.log(msg)
    print("[yUI Debug] "..tostring(msg))
end

function Debug.warn(msg)
    warn("[yUI Debug] "..tostring(msg))
end

function Debug.error(msg)
    error("[yUI Debug] "..tostring(msg))
end

return Debug
