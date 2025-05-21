LibName = "zyke_lib"
Context = IsDuplicityVersion() and "server" or "client"

ResName = GetCurrentResourceName()
TrimmedResName = ResName:sub(6, #ResName) -- Removes zyke_

local function empty() end

-- Load the chunk & function
local function loadFunc(path, self, index)
    self[index] = empty

    local contextChunk = LoadResourceFile(LibName, ("%s/%s/%s.lua"):format(path, index, Context))
    local sharedChunk = LoadResourceFile(LibName, ("%s/%s/shared.lua"):format(path, index))

    local chunk = sharedChunk or contextChunk
    local _context = sharedChunk and "shared" or Context

    if (chunk) then
        local func, err = load(chunk, ("@@%s/%s/%s/%s.lua"):format(LibName, path, index, _context))

        if (not func or err) then
            return error(err)
        end

        local res = func()
        self[index] = res or empty

        return self[index]
    end
end

-- If the function is not cached, load it and cache it
-- Once it is cached, this will no longer run
local function execute(path, self, index, ...)
    local module = loadFunc(path, self, index)

    if (not module) then
        local function export(...)
            return exports[LibName][index](nil, ...)
        end

        if (not ...) then
            self[index] = export
        end

        return export
    end

    return module
end

Functions = setmetatable({
    name = LibName,
}, {
    __index = function(self, index)
        return execute("functions", self, index)
    end,
    __call = function(self, index, ...)
        return execute("functions", self, index, ...)
    end,
})

Formatting = setmetatable({
    name = LibName,
}, {
    __index = function(self, index)
        return execute("formatting", self, index)
    end,
    __call = function(self, index, ...)
        return execute("formatting", self, index, ...)
    end,
})

-- Shorthand
Z = Functions

-- ##### Dependencies ##### --

---@param fileName string
---@return function
local function loadSystem(fileName)
    local chunk = LoadResourceFile(LibName, ("systems/%s.lua"):format(fileName))

    return load(chunk)()
end

loadSystem("framework")
loadSystem("inventory")
loadSystem("target")
loadSystem("gang")
loadSystem("fuel")
loadSystem("death")

LibConfig = load(LoadResourceFile(LibName, "config.lua"))()
T, Translations = load(LoadResourceFile(LibName, "translations.lua"))()

-- Id/name for keymapping, to track if you are still holding the button
HoldingKeys = {}

-- ##### Force Loading ##### --

-- Force loading to ensure both contexts are started
local forceLoad = {
    "notify/client.lua",
    "createUniqueId/server.lua",
    "hasPermission/server.lua",
    "getPlayersOnJob/server.lua",
    "getJobData/server.lua",
    "getGangData/server.lua",
    "getCharacter/server.lua",
    "getVehicles/server.lua",
    "getAccountIdentifier/server.lua",
    "getJobs/server.lua",
    "getPlayers/server.lua",
    "getPlayersInArea/server.lua"
}

for i = 1, #forceLoad do
    local start = forceLoad[i]:find("/")
    local name = forceLoad[i]:sub(1, start - 1)

    loadFunc("functions", Functions, name)
end