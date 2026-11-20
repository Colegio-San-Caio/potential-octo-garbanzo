-- main.lua - the KDP profile in Lua
local id = "KDPMember:KL5UQ4f48673352"
local prefix = "KDPMember:"

-- the short code after the "KDPMember:" prefix
local function short_code(s)
  if s:sub(1, #prefix) == prefix then return s:sub(#prefix + 1) end
  return s
end

print("=== KDP Forum Profile ===")
print("Nickname : " .. id)
print("Code     : " .. short_code(id))
print("Role     : Member")
print("Points   : 1")
