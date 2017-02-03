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

-- ロード
if not g.loaded then
    local t, err = acutil.loadJSON(g.settingFileLoc, g.settings);
    if err then
    CHAT_SYSTEM(addonName.." cannot load setting files");
        g.settings = {
            button1 = {
            title = "すき",
            msg = "$g こうしすき"
        },
        button2 = {
            title = "きらい",
            msg = "$g こうしきらい"
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
            title = "",
            msg = ""
        },
        button6 = {
            title = "",
            msg = ""
        },
        button7 = {
            title = "",
            msg = ""
        }
    };
    else
        g.settings = t;
    end
    g.loaded = true;
end

function CHATBTN_ON_INIT(addon, frame)
    --コマンドとボタン
    acutil.slashCommand("/chbt", CHATBTN_COMMAND);
    addon:RegisterMsg('GAME_START','CHATBTN_CREATE_BUTTONS');
end

function CHATBTN_CREATE_BUTTONS()
    local frame = ui.GetFrame('chatframe');
    chatbutton = {};
    
    for i = 1, 1 do
        chatbutton[i] = frame:CreateOrGetControl('button', "chatbutton["..i.."]", 0, 1, 75, 25);
        chatbutton[i] = tolua.cast(chatbutton[i], "ui::CButton");
        chatbutton[i]:SetText("{s14}"..g["settings"]["button"..i]["title"]);
        chatbutton[i]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK("..i..")");
        chatbutton[i]:SetClickSound('button_click_big');
        chatbutton[i]:SetOverSound('button_over');
    end

    -- ボタン2
    chatbutton[2] = frame:CreateOrGetControl('button', "chatbutton[2]", 75, 1, 75, 25);
    chatbutton[2] = tolua.cast(chatbutton[2], "ui::CButton");
    chatbutton[2]:SetText("{s14}"..g.settings.button2.title);
    chatbutton[2]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(2)");
    chatbutton[2]:SetClickSound('button_click_big');
    chatbutton[2]:SetOverSound('button_over');

    -- ボタン3
    chatbutton[3] = frame:CreateOrGetControl('button', "chatbutton3", 150, 1, 75, 25);
    chatbutton[3] = tolua.cast(chatbutton3, "ui::CButton");
    chatbutton[3]:SetText("{s14}"..g.settings.button3.title);
    chatbutton[3]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(3)");
    chatbutton[3]:SetClickSound('button_click_big');
    chatbutton[3]:SetOverSound('button_over');
    
    -- ボタン4
    chatbutton[4] = frame:CreateOrGetControl('button', "chatbutton[4]", 225, 1, 75, 25);
    chatbutton[4] = tolua.cast(chatbutton[4], "ui::CButton");
    chatbutton[4]:SetText("{s14}"..g.settings.button4.title);
    chatbutton[4]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(4)");
    chatbutton[4]:SetClickSound('button_click_big');
    chatbutton[4]:SetOverSound('button_over');

    -- ボタン5
    chatbutton[5] = frame:CreateOrGetControl('button', "chatbutton[5]", 300, 1, 75, 25);
    chatbutton[5] = tolua.cast(chatbutton[5], "ui::CButton");
    chatbutton[5]:SetText("{s14}"..g.settings.button5.title);
    chatbutton[5]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(5)");
    chatbutton[5]:SetClickSound('button_click_big');
    chatbutton[5]:SetOverSound('button_over');

    -- ボタン6
    chatbutton[6] = frame:CreateOrGetControl('button', "chatbutton[6]", 375, 1, 75, 25);
    chatbutton[6] = tolua.cast(chatbutton[6], "ui::CButton");
    chatbutton[6]:SetText("{s14}"..g.settings.button6.title);
    chatbutton[6]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(6)");
    chatbutton[6]:SetClickSound('button_click_big');
    chatbutton[6]:SetOverSound('button_over');

    -- ボタン7
    chatbutton[7] = frame:CreateOrGetControl('button', "chatbutton[7]", 450, 1, 75, 25);
    chatbutton[7] = tolua.cast(chatbutton[7], "ui::CButton");
    chatbutton[7]:SetText("{s14}"..g.settings.button7.title);
    chatbutton[7]:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK(7)");
    chatbutton[7]:SetClickSound('button_click_big');
    chatbutton[7]:SetOverSound('button_over');
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
        CHAT_SYSTEM("/chbt msg 1 or /chbt title 1");
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