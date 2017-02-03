-- 定義
local addonName = "CHATBTN";
local addonNameLower = string.lower(addonName); 

-- 初期設定
_G['ADDONS'] = _G['ADDONS'] or {};
_G['ADDONS'][addonName] = _G['ADDONS'][addonName] or {};
local g = _G['ADDONS'][addonName];
g.settingFileLoc = "../addons/"..addonNameLower.."/setting.json";
local acutil = require("acutil");
CHAT_SYSTEM(addonName.." loaded! help: /chbt");

local default = {
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
        msg = "/indun"
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
        end
        g.loaded = true;
    end

    acutil.slashCommand("/chbt", CHATBTN_COMMAND);
    addon:RegisterMsg('GAME_START','CHATBTN_CREATE_BUTTONS');
end

function CHATBTN_CREATE_BUTTONS()
    local frame = ui.GetFrame('chatframe');
    chatbutton = {};
    
    for i = 1, 7 do
        chatbutton[i] = frame:CreateOrGetControl('button', "chatbutton["..i.."]", 70 * (i - 1) - i + 1, 1, 74, 25);
        chatbutton[i] = tolua.cast(chatbutton[i], "ui::CButton");
        chatbutton[i]:SetText("{s14}"..g["settings"]["button"..i]["title"]);
        chatbutton[i]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK("..i..")");
        chatbutton[i]:SetClickSound('button_click_big');
        chatbutton[i]:SetOverSound('button_over');
    end
end

function CHATBTN_ON_CLICK(num)
    local msg = g["settings"]["button"..num]["msg"];
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_COMMAND(command)
    local cmd = table.remove(command, 1);
    if not cmd then
        CHAT_SYSTEM("/chbt msg [数字] [メッセージ] or /chbt title [数字] [タイトル]");
    elseif cmd == 'msg' then
        local msg = "";
        cmd = table.remove(command, 1);
        for index, item in ipairs(command) do
            msg = msg..item.." ";
        end
        msg = string.sub(msg, 1, #msg - 1);
        
        if cmd == "1" then
            CHATBTN_SET_MSG(1, msg);
        elseif cmd == "2" then
            CHATBTN_SET_MSG(2, msg);
        elseif cmd == "3" then
            CHATBTN_SET_MSG(3, msg);
        elseif cmd == "4" then 
            CHATBTN_SET_MSG(4, msg);
        elseif cmd == "5" then 
            CHATBTN_SET_MSG(5, msg);
        elseif cmd == "6" then 
            CHATBTN_SET_MSG(6, msg);
        elseif cmd == "7" then 
            CHATBTN_SET_MSG(7, msg);
        end
        
    elseif cmd == 'title' then
        local title = "";
        cmd = table.remove(command, 1);
        title = table.remove(command, 1);

        if cmd == "1" then
            CHATBTN_SET_TITLE(1, title);
        elseif cmd == "2" then
            CHATBTN_SET_TITLE(2, title);
        elseif cmd == "3" then
            CHATBTN_SET_TITLE(3, title);
        elseif cmd == "4" then 
            CHATBTN_SET_TITLE(4, title);
        elseif cmd == "5" then 
            CHATBTN_SET_TITLE(5, title);
        elseif cmd == "6" then 
            CHATBTN_SET_TITLE(6, title);
        elseif cmd == "7" then 
            CHATBTN_SET_TITLE(7, title);
        end  
    end
    acutil.saveJSON(g.settingFileLoc, g.settings);
end

function CHATBTN_SET_MSG(num, msg)
    g["settings"]["button"..num]["msg"] = msg;
    CHAT_SYSTEM("ボタン"..num.."のメッセージに「"..g["settings"]["button"..num]["msg"].."」を設定しました。");
    if string.sub(g["settings"]["button"..num]["msg"], 1, 1) == "/" then
        g["settings"]["button"..num]["msg"] = "$"..string.sub(g["settings"]["button"..num]["msg"], 2, #g["settings"]["button"..num]["msg"]);
    end
end

function CHATBTN_SET_TITLE(num, title)
    g["settings"]["button"..num]["title"] = title;
    chatbutton[num]:SetText("{s14}"..g["settings"]["button"..num]["title"]);
    CHAT_SYSTEM("ボタン"..num.."のタイトルに「"..g["settings"]["button"..num]["title"].."」を設定しました。");
end