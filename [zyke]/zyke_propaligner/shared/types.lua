---@class AlignmentData
---@field dict string
---@field clip string
---@field props PropAlignmentData[]

---@class PropAlignmentData
---@field prop string
---@field bone integer
---@field offset Vector3Table
---@field rotation Vector3Table

---@class EditingPropData : PropAlignmentData
---@field entity? integer

---@class PresetData : AlignmentData
---@field created OsTime

---@class HistoryData : PresetData
---@class ExportData : AlignmentData

---@class Preset
---@field id string
---@field label string
---@field data PresetData

-- Most same as preset, but:
-- Does not carry an id since that will be created
-- Does not save a created timestamp, as that will be created
---@class Export
---@field label string
---@field data ExportData

---@alias OsTime integer
---@alias Vector3Table table{x: number, y: number, z: number}
---@alias Vector3Array [number, number, number]
---@alias PlayerId integer
---@alias Success boolean
---@alias FailReason string
---@alias JSON string