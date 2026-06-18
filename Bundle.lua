-- [[ PandaUI | Bundle ]]

-- 1. ضع هنا الثيم (الذي كان في سكربت الألوان)
local Theme = {
    Background = Color3.fromRGB(12, 12, 14),
    -- باقي الألوان...
}

-- 2. ضع هنا أدواتك (التي كانت في سكربت الأدوات)
local Utils = {}
function Utils.Tween(...) end 
-- باقي الدوال...

-- 3. ضع هنا المحرك الرئيسي (الذي كان في سكربت الواجهة)
local function CreateMainLibrary()
    local Library = {}
    
    -- استخدم Theme و Utils هنا مباشرة
    -- Library.Theme = Theme
    
    return Library
end

-- 4. في النهاية، هذا هو السطر الذي يخرج المكتبة للعالم
return CreateMainLibrary()
