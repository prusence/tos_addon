-- 初期設定
_G['ADDONS'] = _G['ADDONS'] or {};
_G['ADDONS']['CHATBTN'] = _G['ADDONS']['CHATBTN'] or {};
local g = _G['ADDONS']['CHATBTN'];
g.settingFileLoc = "../addons/chatbtn/setting.json";
local acutil = require("acutil");
CHAT_SYSTEM("chatbtn loaded! help: /chbt");

function CHATBTN_ON_INIT(addon, frame)
    -- ロード
    if not g.loaded then
        local t, err = acutil.loadJSON(g.settingFileLoc, g.settings);
        if err then
            CHAT_SYSTEM("chatbtn cannot load setting files");
            g.settings = {
                button1 = {
                title = "すき",
                msg = "/g こうしすき"
            },
            button2 = {
                title = "きらい",
                msg = "/g こうしきらい"
            },
            button3 = {
                title = "よろ",
                msg = "/p よろしくおねがいします"
            },
            button4 = {
                title = "おつ",
                msg = "/p おつかれさまでした"
            }
        };
        else
            g.settings = t;
        end
        g.loaded = true;
    end

    --コマンドとボタン
    acutil.slashCommand("/chbt", CHATBTN_COMMAND);
    addon:RegisterMsg('GAME_START','CHATBTN_CREATE_BUTTONS');
end

function CHATBTN_CREATE_BUTTONS()
    local frame = ui.GetFrame('chatframe');
    
    -- ボタン1
    chatbutton1 = frame:CreateOrGetControl('button', "chatbutton1", 0, 1, 75, 25);
    chatbutton1 = tolua.cast(chatbutton1, "ui::CButton");
    chatbutton1:SetText("{s14}"..g.settings.button1.title);
    chatbutton1:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK");
    chatbutton1:SetClickSound('button_click_big');
    chatbutton1:SetOverSound('button_over');

    -- ボタン2
    chatbutton2 = frame:CreateOrGetControl('button', "chatbutton2", 75, 1, 75, 25);
    chatbutton2 = tolua.cast(chatbutton2, "ui::CButton");
    chatbutton2:SetText("{s14}"..g.settings.button2.title);
    chatbutton2:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK2");
    chatbutton2:SetClickSound('button_click_big');
    chatbutton2:SetOverSound('button_over');

    -- ボタン3
    chatbutton3 = frame:CreateOrGetControl('button', "chatbutton3", 150, 1, 75, 25);
    chatbutton3 = tolua.cast(chatbutton3, "ui::CButton");
    chatbutton3:SetText("{s14}"..g.settings.button3.title);
    chatbutton3:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK3");
    chatbutton3:SetClickSound('button_click_big');
    chatbutton3:SetOverSound('button_over');
    
    -- ボタン4
    chatbutton4 = frame:CreateOrGetControl('button', "chatbutton4", 225, 1, 75, 25);
    chatbutton4 = tolua.cast(chatbutton4, "ui::CButton");
    chatbutton4:SetText("{s14}"..g.settings.button4.title);
    chatbutton4:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK4");
    chatbutton4:SetClickSound('button_click_big');
    chatbutton4:SetOverSound('button_over');
end

function CHATBTN_ON_CLICK()
    ui.Chat(g.settings.button1.msg);
end

function CHATBTN_ON_CLICK2()
    ui.Chat(g.settings.button2.msg);
end

function CHATBTN_ON_CLICK3()
    ui.Chat(g.settings.button3.msg);
end

function CHATBTN_ON_CLICK4()
    ui.Chat(g.settings.button4.msg);
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
        local n = #msg;
        
        if cmd == "1" then
            g.settings.button1.msg = string.sub(msg, 1, n - 1);
        elseif cmd == "2" then
            g.settings.button2.msg = string.sub(msg, 1, n - 1);
        elseif cmd == "3" then
            g.settings.button3.msg = string.sub(msg, 1, n - 1);
        elseif cmd == "4" then 
            g.settings.button4.msg = string.sub(msg, 1, n - 1);
        end
        
    elseif cmd == 'title' then
        local txt = "";
        cmd = table.remove(command, 1);
        txt = table.remove(command, 1);

        if cmd == "1" then
            g.settings.button1.title = txt;
            chatbutton1:SetText("{s14}"..g.settings.button1.title);
        elseif cmd == "2" then
            g.settings.button2.title = txt;
            chatbutton2:SetText("{s14}"..g.settings.button2.title);
        elseif cmd == "3" then
            g.settings.button3.title = txt;
            chatbutton3:SetText("{s14}"..g.settings.button3.title);
        elseif cmd == "4" then 
            g.settings.button4.title = txt;
            chatbutton4:SetText("{s14}"..g.settings.button4.title);
        end  
    end
    acutil.saveJSON(g.settingFileLoc, g.settings);
end