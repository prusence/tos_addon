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

    -- ボタン5
    chatbutton5 = frame:CreateOrGetControl('button', "chatbutton5", 300, 1, 75, 25);
    chatbutton5 = tolua.cast(chatbutton5, "ui::CButton");
    chatbutton5:SetText("{s14}"..g.settings.button5.title);
    chatbutton5:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK5");
    chatbutton5:SetClickSound('button_click_big');
    chatbutton5:SetOverSound('button_over');

    -- ボタン6
    chatbutton6 = frame:CreateOrGetControl('button', "chatbutton6", 375, 1, 75, 25);
    chatbutton6 = tolua.cast(chatbutton6, "ui::CButton");
    chatbutton6:SetText("{s14}"..g.settings.button6.title);
    chatbutton6:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK6");
    chatbutton6:SetClickSound('button_click_big');
    chatbutton6:SetOverSound('button_over');

    -- ボタン7
    chatbutton7 = frame:CreateOrGetControl('button', "chatbutton7", 450, 1, 75, 25);
    chatbutton7 = tolua.cast(chatbutton7, "ui::CButton");
    chatbutton7:SetText("{s14}"..g.settings.button7.title);
    chatbutton7:SetEventScript(ui.LBUTTONUP, "CHATBTN_ON_CLICK7");
    chatbutton7:SetClickSound('button_click_big');
    chatbutton7:SetOverSound('button_over');
end

function CHATBTN_ON_CLICK()
    local msg = g.settings.button1.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK2()
    local msg = g.settings.button2.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK3()
    local msg = g.settings.button3.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK4()
    local msg = g.settings.button4.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK5()
    local msg = g.settings.button5.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK6()
    local msg = g.settings.button6.msg;
    if string.sub(msg, 1, 1) == "$" then
        msg = "/"..string.sub(msg, 2, #msg);
    end
    ui.Chat(msg);
end

function CHATBTN_ON_CLICK7()
    local msg = g.settings.button7.msg;
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
        local n = #msg;
        
        if cmd == "1" then
            g.settings.button1.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン1のメッセージに「"..g.settings.button1.msg.."」を設定しました。");
            if string.sub(g.settings.button1.msg, 1, 1) == "/" then
                g.settings.button1.msg = "$"..string.sub(g.settings.button1.msg, 2, #g.settings.button1.msg);
            end
        elseif cmd == "2" then
            g.settings.button2.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン2のメッセージに「"..g.settings.button2.msg.."」を設定しました。");
            if string.sub(g.settings.button2.msg, 1, 1) == "/" then
                g.settings.button2.msg = "$"..string.sub(g.settings.button2.msg, 2, #g.settings.button2.msg);
            end
        elseif cmd == "3" then
            g.settings.button3.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン3のメッセージに「"..g.settings.button3.msg.."」を設定しました。");
            if string.sub(g.settings.button3.msg, 1, 1) == "/" then
                g.settings.button3.msg = "$"..string.sub(g.settings.button3.msg, 2, #g.settings.button3.msg);
            end
        elseif cmd == "4" then 
            g.settings.button4.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン4のメッセージに「"..g.settings.button4.msg.."」を設定しました。");
            if string.sub(g.settings.button4.msg, 1, 1) == "/" then
                g.settings.button4.msg = "$"..string.sub(g.settings.button4.msg, 2, #g.settings.button4.msg);
            end
        elseif cmd == "5" then 
            g.settings.button5.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン5のメッセージに「"..g.settings.button5.msg.."」を設定しました。");
            if string.sub(g.settings.button5.msg, 1, 1) == "/" then
                g.settings.button5.msg = "$"..string.sub(g.settings.button5.msg, 2, #g.settings.button5.msg);
            end
        elseif cmd == "6" then 
            g.settings.button6.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン6のメッセージに「"..g.settings.button6.msg.."」を設定しました。");
            if string.sub(g.settings.button6.msg, 1, 1) == "/" then
                g.settings.button6.msg = "$"..string.sub(g.settings.button6.msg, 2, #g.settings.button6.msg);
            end
        elseif cmd == "7" then 
            g.settings.button7.msg = string.sub(msg, 1, n - 1);
            CHAT_SYSTEM("ボタン7のメッセージに「"..g.settings.button7.msg.."」を設定しました。");
            if string.sub(g.settings.button7.msg, 1, 1) == "/" then
                g.settings.button7.msg = "$"..string.sub(g.settings.button7.msg, 2, #g.settings.button7.msg);
            end
        end
        
    elseif cmd == 'title' then
        local txt = "";
        cmd = table.remove(command, 1);
        txt = table.remove(command, 1);

        if cmd == "1" then
            g.settings.button1.title = txt;
            chatbutton1:SetText("{s14}"..g.settings.button1.title);
            CHAT_SYSTEM("ボタン1のタイトルに「"..g.settings.button1.title.."」を設定しました。");
        elseif cmd == "2" then
            g.settings.button2.title = txt;
            chatbutton2:SetText("{s14}"..g.settings.button2.title);
            CHAT_SYSTEM("ボタン2のタイトルに「"..g.settings.button2.title.."」を設定しました。");
        elseif cmd == "3" then
            g.settings.button3.title = txt;
            chatbutton3:SetText("{s14}"..g.settings.button3.title);
            CHAT_SYSTEM("ボタン3のタイトルに「"..g.settings.button3.title.."」を設定しました。");
        elseif cmd == "4" then 
            g.settings.button4.title = txt;
            chatbutton4:SetText("{s14}"..g.settings.button4.title);
            CHAT_SYSTEM("ボタン4のタイトルに「"..g.settings.button4.title.."」を設定しました。");
        elseif cmd == "5" then 
            g.settings.button5.title = txt;
            chatbutton5:SetText("{s14}"..g.settings.button5.title);
            CHAT_SYSTEM("ボタン4のタイトルに「"..g.settings.button5.title.."」を設定しました。");
        elseif cmd == "6" then 
            g.settings.button6.title = txt;
            chatbutton6:SetText("{s14}"..g.settings.button6.title);
            CHAT_SYSTEM("ボタン4のタイトルに「"..g.settings.button6.title.."」を設定しました。");
        elseif cmd == "7" then 
            g.settings.button7.title = txt;
            chatbutton7:SetText("{s14}"..g.settings.button7.title);
            CHAT_SYSTEM("ボタン4のタイトルに「"..g.settings.button7.title.."」を設定しました。");
        end  
    end
    acutil.saveJSON(g.settingFileLoc, g.settings);
end