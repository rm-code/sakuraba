--==================================================================================
-- Copyright (C) 2015 by Robert Machmer                                            =
--                                                                                 =
-- Permission is hereby granted, free of charge, to any person obtaining a copy    =
-- of this software and associated documentation files (the "Software"), to deal   =
-- in the Software without restriction, including without limitation the rights    =
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       =
-- copies of the Software, and to permit persons to whom the Software is           =
-- furnished to do so, subject to the following conditions:                        =
--                                                                                 =
-- The above copyright notice and this permission notice shall be included in      =
-- all copies or substantial portions of the Software.                             =
--                                                                                 =
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      =
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        =
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     =
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          =
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   =
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN       =
-- THE SOFTWARE.                                                                   =
--==================================================================================

local Bresenham = {};

---
-- Maps a line from point (ox, oy) to point (ex, ey) onto a two dimensional
-- tile grid.
--
-- The callback function will be called for each tile the line passes on its
-- way from the origin to the target tile. The line algorithm can be stopped
-- early by making the callback return false.
--
-- @ox - The x-coordinates of the origin.
-- @oy - The y-coordinates of the origin.
-- @ex - The x-coordinates of the target.
-- @ey - The y-coordinates of the target.
-- @callback - A callback function being called for every tile the line passes.
--
function Bresenham.calculateLine(ox, oy, ex, ey, callback)
    if not callback then return end

    local dx = math.abs(ex - ox);
    local dy = math.abs(ey - oy) * -1;

    local sx = ox < ex and 1 or -1;
    local sy = oy < ey and 1 or -1;
    local err = dx + dy;

    local counter = 0;
    while true do
        counter = counter + 1;
        local continue = callback(ox, oy, counter);

        if not continue then
            return;
        end

        if ox == ex and oy == ey then
            return;
        end

        local tmpErr = 2 * err;
        if tmpErr > dy then
            err = err + dy;
            ox = ox + sx;
        end
        if tmpErr < dx then
            err = err + dx;
            oy = oy + sy;
        end
    end
end

return Bresenham;
