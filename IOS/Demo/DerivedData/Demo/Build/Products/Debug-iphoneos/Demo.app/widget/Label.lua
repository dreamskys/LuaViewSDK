--
-- Created by IntelliJ IDEA.
-- User: tuoli
-- Date: 2/7/17
-- Time: 16:30
-- To change this template use File | Settings | File Templates.
--

Navigation:title("Label.lua")

local _screenWidth, _screenHeight = System:screenSize()

-- 减掉ActionBar和StatusBar的高度
if (System:android()) then
    local device = System:device()
    _screenHeight = device.window_height - device.status_bar_height - device.nav_height
else
    _screenHeight = _screenHeight - 64      -- iOS, 稳定在这个值
end

local function start()
    local tableData = {
        Section = {
            SectionCount = function()
                return 1
            end,
            RowCount = function(section)
                return 1
            end
        },
        Cell = {
            Id = function(section, row)
                return "LabelCell"
            end,
            LabelCell = {
                Size = function(section, row)
                    return _screenWidth, _screenHeight*2.5
                end,
                Init = function(cell, section, row)
                    local pica = require("kit.pica")

                    print("tuoli", "xml read start")
                    local data = File:read("widget/label.xml")
                    print("tuoli", "xml read end")
                    pica:parseXml(data)

                    local root = pica:getViewByName("root")
                    cell.window:addView(root)

                    local fs1 = pica:getViewByName("fs1")
                    fs1:text(StyledString("normal", {fontStyle = "normal", fontSize=25}))
                    local fs2 = pica:getViewByName("fs2")
                    fs2:text(StyledString("bold", {fontStyle = "bold", fontSize=25}))
                    local fs3 = pica:getViewByName("fs3")
                    fs3:text(StyledString("italic", {fontStyle = "italic", fontSize=25}))
                    local td1 = pica:getViewByName("td1")
                    td1:text(StyledString("strikethrough", {strikethrough = true, fontSize=25}))
                    local td2 = pica:getViewByName("td2")
                    td2:text(StyledString("underline", {underline = true, fontSize=25}))
                end
            }
        }
    }
    tableView = CollectionView(tableData)
    tableView:frame(0, 0, _screenWidth, _screenHeight)
end

start()