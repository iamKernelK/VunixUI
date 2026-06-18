-- [[ PandaUI | Bundle Release ]]
-- هذا الملف مجمع آلياً من ملفات الـ Source الأصلية

local PandaUI = {}

-- 1. دمج الـ Theme
PandaUI.Theme = {
    -- انسخ هنا ما في Theme.lua
}

-- 2. دمج الـ Utilities
local Utils = {}
-- انسخ هنا الدوال الموجودة في Utilities.lua
PandaUI.Utils = Utils

-- 3. دمج العناصر (Elements Engine)
local Elements = {}
-- ضع هنا دوال Button, Slider, Toggle, Dropdown
PandaUI.Elements = Elements

-- 4. المحرك الرئيسي (Window & Tabs)
-- هنا ضع منطق init.lua الخاص بك
function PandaUI:CreateWindow(Config)
    -- استخدم العناصر من PandaUI.Elements مباشرة
    -- لا تستخدم require هنا أبداً
end

return PandaUI

