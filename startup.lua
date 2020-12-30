os.loadAPI("bigfont")

--GAME VERSION
local GAME_VERSION = "v1.0.0"

local monitor = peripheral.find("monitor")

local CURRENCY = "ckmod:vbucks" --Item that the turtle accepts as tokens
local CREDITS = 0
local CREDITCOST = 4 --Token cost per play

turtle.select(1)
term.redirect(monitor)
--term.setPaletteColor(colors.green, 0x00AA00)

local MONITOR_WIDTH, MONITOR_HEIGHT = term.getSize()
local screenCenterX = math.ceil(MONITOR_WIDTH/2)
local screenCenterY = math.ceil(MONITOR_HEIGHT/2)
local currTerm = term.current()
local window = window.create(currTerm,1,1,MONITOR_WIDTH,MONITOR_HEIGHT,false)

local clickX = 0
local clickY = 0
local clicked = false

--Possible earnings
local EARNINGS = {}
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Try Again")
table.insert(EARNINGS, "Gold")
table.insert(EARNINGS, "Gold")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Coal")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Copper")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Tin")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Dirt")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Cobblestone")
table.insert(EARNINGS, "Diamond")
table.insert(EARNINGS, "Emerald")

local WINNINGS = {}
table.insert(WINNINGS, "Dirt")
table.insert(WINNINGS, "Dirt")
table.insert(WINNINGS, "Dirt")
table.insert(WINNINGS, "Cobblestone")
table.insert(WINNINGS, "Cobblestone")
table.insert(WINNINGS, "Cobblestone")
table.insert(WINNINGS, "Coal")
table.insert(WINNINGS, "Coal")
table.insert(WINNINGS, "Copper")
table.insert(WINNINGS, "Copper")
table.insert(WINNINGS, "Tin")
table.insert(WINNINGS, "Tin")
table.insert(WINNINGS, "Diamond")
table.insert(WINNINGS, "Emerald")
table.insert(WINNINGS, "Gold")

--Game vars
local GAMESTATE = 0
local GAMESPIN = -40
local SPINSPEED = 3
local SPINTEXT1 = "SPINNING"
local SPINTEXT2 = "SPINNING"
local SPINTEXT3 = "SPINNING"

--Menu vars
local MENUSPIN = 0


function draw_menu()
    paintutils.drawFilledBox(1,1,MONITOR_WIDTH,MONITOR_HEIGHT,colors.blue)

    MENUSPIN = MENUSPIN + 1
    if MENUSPIN > MONITOR_HEIGHT-1 then MENUSPIN = 2 end

    window.setTextColor(colors.black)
    window.setBackgroundColor(colors.blue)
    window.setCursorPos(1,1)

    local txt = "Spin to Win"
    bigfont.writeOn(term,1,txt,screenCenterX-(#txt*1.5)+1, MENUSPIN-(MONITOR_HEIGHT/3))
    bigfont.writeOn(term,1,txt,screenCenterX-(#txt*1.5)+1, MENUSPIN)
    bigfont.writeOn(term,1,txt,screenCenterX-(#txt*1.5)+1, MENUSPIN+(MONITOR_HEIGHT/3))

    paintutils.drawFilledBox(1,1,MONITOR_WIDTH,5,colors.black)
    paintutils.drawFilledBox(1,MONITOR_HEIGHT-4,MONITOR_WIDTH,MONITOR_HEIGHT,colors.black)

    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(1,MONITOR_HEIGHT)
    term.write("V-Bucks: " .. CREDITS)
end

function draw_game()
    paintutils.drawFilledBox(1,1,MONITOR_WIDTH,MONITOR_HEIGHT,colors.green)

    GAMESPIN = GAMESPIN + SPINSPEED
    if GAMESPIN > MONITOR_HEIGHT-1 then
        GAMESPIN = GAMESPIN - (MONITOR_HEIGHT-1)
        SPINSPEED = SPINSPEED - 0.25

        if SPINSPEED <= 0 then

            for i=1,#WINNINGS do
                --os.sleep()
                if WINNINGS[i] == SPINTEXT1 then
                    turtle.select(i+1)
                    if turtle.getItemCount() > 0 then
                        turtle.dropUp(1)
                        os.sleep()
                        redstone.setOutput("top", true)
                        os.sleep()
                        redstone.setOutput("top", false)
                        break
                    end
                end
            end

            --os.sleep()
            turtle.select(1)

            os.sleep(5)

            GAMESTATE = 0
            return true
        else
            SPINTEXT3 = SPINTEXT1
            SPINTEXT2 = EARNINGS[math.ceil(math.random(#EARNINGS))]
            SPINTEXT1 = EARNINGS[math.ceil(math.random(#EARNINGS))]
        end
    end

    if GAMESTATE ~= 0 then
        window.setTextColor(colors.black)
        window.setBackgroundColor(colors.green)
        window.setCursorPos(1,1)

        bigfont.writeOn(term,1,SPINTEXT1,screenCenterX-(#SPINTEXT1*1.5)+1, GAMESPIN-(MONITOR_HEIGHT/3))
        bigfont.writeOn(term,1,SPINTEXT2,screenCenterX-(#SPINTEXT2*1.5)+1, GAMESPIN)
        bigfont.writeOn(term,1,SPINTEXT3,screenCenterX-(#SPINTEXT3*1.5)+1, GAMESPIN+(MONITOR_HEIGHT/3))

        paintutils.drawFilledBox(1,1,MONITOR_WIDTH,5,colors.black)
        paintutils.drawFilledBox(1,MONITOR_HEIGHT-4,MONITOR_WIDTH,MONITOR_HEIGHT,colors.black)
    end
end

function draw()
    term.redirect(window)

    if GAMESTATE == 0 then
        draw_menu()
    else
        draw_game()
    end
    term.redirect(currTerm)
    window.setVisible(true)
    window.setVisible(false)
end

function game()

    --Get V-Bucks
    local itemInfo = turtle.getItemDetail()
    if itemInfo ~= nil then
        if itemInfo.name == CURRENCY then
         CREDITS = CREDITS + 1
        end
        turtle.dropDown(1)
    end

    if GAMESTATE == 0 then
        if CREDITS >= CREDITCOST then
            CREDITS = CREDITS - CREDITCOST
            
            GAMESPIN = -40
            SPINSPEED = 3
            SPINTEXT1 = "SPINNING"
            SPINTEXT2 = "SPINNING"
            SPINTEXT3 = "SPINNING"
            
            GAMESTATE = 1
        end
    end


end

function main_game()

    draw()
    game()

    if GAMESTATE == 0 then
        os.sleep(0.2)
    else
        os.sleep()
    end

end

while true do
    main_game()
end