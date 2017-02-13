-- 定義
local addonName = "CHATBTN";
local addonNameLower = string.lower(addonName); 

-- 初期設定
_G['ADDONS'] = _G['ADDONS'] or {};
_G['ADDONS'][addonName] = _G['ADDONS'][addonName] or {};
local g = _G['ADDONS'][addonName];
g.settingFileLoc = "../addons/"..addonNameLower.."/setting.json";
local acutil = require("acutil");
local chatbutton = {};
CHAT_SYSTEM(addonName.." loaded! help: /chbt");

local default = {
    count = 7,
    size = 72,
    button1 = {
        title = "すき",
        msg = "$g すき"
    },
    button2 = {
        title = "きらい",
        msg = "$g きらい"
    },
    button3 = {
        title = "よろ",
        msg = "$p よろしくおねがいします"
    },
    button4 = {
        title = "おつ",
        msg = "$p おつかれさまでした"
    },
    button5 = {
        title = "笑み",
        msg = "{img emoticon_0008 30 30}{\/}"
    },
    button6 = {
        title = "脱力",
        msg = "{img emoticon_0009 30 30}{\/}"
    },
    button7 = {
        title = "いんだん",
        msg = "$indun"
    }
};

function CHATBTN_ON_INIT(addon, frame)
    if not g.loaded then
        local t, err = acutil.loadJSON(g.settingFileLoc, g.settings);
        if err then
        CHAT_SYSTEM(addonName.." cannot load setting files");
            g.settings = default;
        else
            g.settings = t;
            if g.settings.count == nil then
                g.settings.count = default.count;
            end
            if g.settings.size == nil then
                g.settings.size = default.size;
            end
        end
        g.loaded = true;
    end

    acutil.slashCommand("/chbt", CHATBTN_COMMAND);
    addon:RegisterMsg('GAME_START','CHATBTN_CREATE_BUTTONS');
end

function CHATBTN_CREATE_BUTTONS()
    local frame = ui.GetFrame('chatframe');

    for i = 1, g.settings.count do
        if g["settings"]["button"..i] == nil then
            g["settings"]["button"..i] = { title = " ", msg = " " };
        end
        chatbutton[i] = frame:CreateOrGetControl('button', "chatbutton["..i.."]", (g.settings.size - 3) * (i - 1), 1, g.settings.size, 25);
        chatbutton[i] = tolua.cast(chatbutton[i], "ui::CButton");
        chatbutton[i]:SetText("{s14}"..g["settings"]["button"..i]["title"]);
        chatbutton[i]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK("..i..")");
        chatbutton[i]:SetClickSound('button_click_big');
        chatbutton[i]:SetOverSound('button_over');
        chatbutton[i]:SetTextTooltip("{s14}"..UNESCAPE(g["settings"]["button"..i]["msg"]));
        chatbutton[i]:ShowWindow(1);
    end
end

function CHATBTN_ON_CLICK(num)
    ui.Chat(UNESCAPE(g["settings"]["button"..num]["msg"]));
end

function CHATBTN_COMMAND(command)
    local cmd = table.remove(command, 1);
    if not cmd then
        CHAT_SYSTEM("/chbt msg [num] [message]");
        CHAT_SYSTEM("/chbt title [num] [title]");
        CHAT_SYSTEM("/chbt size [num]");
        CHAT_SYSTEM("/chbt count [num]");
    elseif cmd == 'msg' then
        local msg = "";
        cmd = table.remove(command, 1);
        for index, item in ipairs(command) do
            msg = msg..item.." ";
        end
        msg = string.sub(msg, 1, #msg - 1);

        for i = 1, g.settings.count do
            if cmd == i.."" then
                CHATBTN_SET_MSG(i, msg);
                break;
            end
        end
    elseif cmd == 'title' then
        local title = "";
        cmd = table.remove(command, 1);
        title = table.remove(command, 1);

        for i = 1, g.settings.count do
            if cmd == i.."" then
                CHATBTN_SET_TITLE(i, title);
                break;
            end
        end
    elseif cmd == 'size' then
        local size = tonumber(table.remove(command, 1));
        if size == nil then
            CHAT_SYSTEM("Please Input Number!");
            return;
        else
            if CHECK_WIDE(g.settings.count, size) == false then
                return;
            end
            g.settings.size = size;
            CHAT_SYSTEM("Set the button size to "..g.settings.size);
            CHATBTN_CREATE_BUTTONS();
        end
    elseif cmd == 'count' then
        local count = tonumber(table.remove(command, 1));
        if count == nil then
            CHAT_SYSTEM("Please Input Number!");
            return;
        else
            if CHECK_WIDE(count, g.settings.size) == false then
                return;
            end
            for i = count + 1, g.settings.count do
                chatbutton[i]:ShowWindow(0);
            end
            g.settings.count = count;
            CHAT_SYSTEM("Set the button count to "..g.settings.count);
            CHATBTN_CREATE_BUTTONS();
        end
    end
    acutil.saveJSON(g.settingFileLoc, g.settings);
end

function CHATBTN_SET_MSG(num, msg)
    chatbutton[num]:SetTextTooltip("{s14}"..g["settings"]["button"..i]["msg"]);
    CHAT_SYSTEM("Set the button"..num.." message to \'"..msg.."\'");
    g["settings"]["button"..num]["msg"] = ESCAPE(msg);
end

function CHATBTN_SET_TITLE(num, title)
    g["settings"]["button"..num]["title"] = title;
    chatbutton[num]:SetText("{s14}"..g["settings"]["button"..num]["title"]);
    CHAT_SYSTEM("Set the button"..num.." title to \'"..g["settings"]["button"..num]["title"].."\'");
end

function CHECK_WIDE(count, size)
    if (size - 3) * count + 3 >= 500 then
        CHAT_SYSTEM("Width will over the range!");
        return false;
    else
        return true;
    end
end

function ESCAPE(string)
    if string.sub(string, 1, 1) == "/" then
        string = "$"..string.sub(string, 2, #string);
    end
    
    return string;
end

function UNESCAPE(string)
    if string.sub(string, 1, 1) == "$" then
        string = "/"..string.sub(string, 2, #string);
    end

    return string;
end