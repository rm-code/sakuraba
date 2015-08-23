---
-- Checks if the object is an instance of a certain class.
-- @param object - The object to examine.
-- @param class  - The name of the class to check against.
--
function instanceof(object, class)
    for i = 1, #object.__instances do
        if object.__instances[i] == class then
            return true;
        end
    end
    return false;
end
