//
// Sega Gamegear Layout for AttractMode
// Layout by Mahuti
// vs. 1.0 
//
local order = 0
class UserConfig {
  
    </ label="Show Logos", 
        help="Shows wheel images when enabled", 
        order=order++, 
        options="Yes, No" />
        show_logos="Yes";
  
    </ label="Show Boxart", 
        help="Shows boxart when enabled", 
        order=order++, 
        options="Yes, No" />
        show_boxart="Yes";
    
    </ label="Show Cards", 
        help="Shows trading cards when enabled", 
        order=order++, 
        options="Yes, No" />
        show_gpk="Yes";
    
 	</ label="Show Playtime", 
        help="The amount of time this game's been played.", 
        order=order++, 
        options="Yes, No, Include Romname" />
        show_playtime="Yes";
    
    </ label="Show Scanlines", 
        help="Shows scanlines when enabled", 
        order=order++, 
        options="Yes, No" />
        show_scanlines="No"; 
    
    </ label="Scratched Text", 
        help="This is some text scratched in the desk, which may not always be visible. Set it to blank to hide it", 
        order=order++
        />
        desk_text="more games than atari...";
}

 
local config = fe.get_config()

fe.do_nut(fe.script_dir + "modules/pos.nut" );
fe.load_module("shadow-glow")

// stretched positioning
local posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "stretch",
    rotate= 0
    debug = true,
}
local stretch = Pos(posData)

// scaled positioning
posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "scale",
    rotate=0
    debug = true,
}
local scale = Pos(posData)
  
//Wood Background
local bg = fe.add_image("bg.png", 0, 0, stretch.width(1920), stretch.height(1080))

/////////////////////////////////////////////////////
//                  Desktop Scratch
/////////////////////////////////////////////////////
local scratch_me = null
if (config["desk_text"] != ""){
    
    local scratch_y = 120
    local scratch_x = 200
    local scratch_width = 1100
    local scratch_height = 200
    local scratch_font_height=44 
    local scratch_rotation = -7
        
    scratch_me = fe.add_text(config["desk_text"], stretch.x(scratch_x), stretch.y(scratch_y), stretch.width(scratch_width), stretch.height(scratch_height) )
    stretch.set_font_height(scratch_font_height,scratch_me, "TopLeft")

    scratch_me.x = scale.x(scratch_x, "left")
    scratch_me.y = scale.y(scratch_y, "top",scratch_me)
    scratch_me.alpha=140
    scratch_me.rotation=scratch_rotation
    scratch_me.set_rgb(150,112,72)
    scratch_me.font = "sugar-death-2-italic.ttf"
        
    local scratch_me2 = fe.add_text(config["desk_text"], stretch.x(scratch_x), stretch.y(scratch_y), stretch.width(scratch_width), stretch.height(scratch_height) )
    scratch_me2.y = scale.y( -2, "top", scratch_me2, scratch_me)
    scratch_me2.x = scale.x( -2, "left", scratch_me2, scratch_me)
    stretch.set_font_height(scratch_font_height,scratch_me2, "TopLeft")
    scratch_me2.alpha=70    
    scratch_me2.rotation=scratch_rotation
    scratch_me2.set_rgb(88,23,41)
    scratch_me2.font = "sugar-death-2-italic.ttf"
}

/////////////////////////////////////////////////////
//                  Garbage Pail Kids
/////////////////////////////////////////////////////

local gpk5 = fe.add_image("cards/cut-up chris.png", 0,0, scale.width(507), scale.height(678))
local gpk4 = fe.add_image("cards/cursed_chris.png", 0,0, scale.width(670), scale.height(775))
local gpk3 = fe.add_image("cards/crusty_chris.png", 0,0, scale.width(754), scale.height(628))
local gpk2 = fe.add_image("cards/crater_chris.png", 0,0, scale.width(795), scale.height(724))

/////////////////////////////////////////////////////
//                  Notebook
/////////////////////////////////////////////////////
local stuart_hall = fe.add_surface(scale.width(1867), scale.height(2004))
local stuart_hall_pages2 = stuart_hall.add_image("stuart_hall_pages2.png",0,0,scale.width(1867), scale.height(2004))
local gpk1 = stuart_hall.add_image("cards/chris_keeper.png",0,0, scale.width(787), scale.height(700))
local stuart_hall_pages1 = stuart_hall.add_image("stuart_hall_pages1.png",0,0,scale.width(1867), scale.height(2004))
local stuart_hall_cover = stuart_hall.add_image("stuart_hall_cover.png",0,0,scale.width(1867), scale.height(2004))


/////////////////////////////////////////////////////
//                  Playtime
/////////////////////////////////////////////////////   
local playtime = null 
if ( config["show_playtime"] == "Yes" )
{
    playtime = fe.add_text("Playtime: [PlayedTime]", stretch.x(14),0, stretch.width(800), stretch.height(20))
}
else
{
    playtime = fe.add_text("Playtime: [PlayedTime] [Name]", stretch.x(14),0, stretch.width(800), stretch.height(20))
}
playtime.set_rgb(10, 10, 10)	
stretch.set_font_height(25,playtime, "BottomLeft")
   
/////////////////////////////////////////////////////
//                  Boxart
/////////////////////////////////////////////////////
local boxart
boxart = fe.add_artwork("boxart", 0,0, scale.width(750), scale.height(750))
boxart.preserve_aspect_ratio = true
boxart.trigger = Transition.EndNavigation
boxart.rotation = -7.5 
boxart.x = scale.x(-150)
boxart.y = scale.y(5)
    
// boxart   
if ( config["show_boxart"] != "Yes" )
{ 
    boxart.alpha = 0
}
else
{
    local ds = DropShadow( boxart, 40, scale.x(20), scale.y(20), 83 )
}
/////////////////////////////////////////////////////
//                   Wheel
/////////////////////////////////////////////////////
local wheel
wheel = fe.add_artwork("wheel", scale.x(1250),scale.y(70), scale.width(400), scale.height(216))
wheel.preserve_aspect_ratio = true
wheel.trigger = Transition.EndNavigation
wheel.alpha=200

/////////////////////////////////////////////////////
//                  Bottle Cap
/////////////////////////////////////////////////////
local bottle_cap = fe.add_image("bottle_cap.png", scale.x(1103), scale.y(485), scale.width(238), scale.height(233))

/////////////////////////////////////////////////////
//                  Gamegear
/////////////////////////////////////////////////////
local gamegear_surface = fe.add_surface(scale.width(1920), scale.height(1200))
gamegear_surface.set_pos(0,0)
    
// underlay
local nogame_underlay = gamegear_surface.add_image("game_underlay.png", scale.x(862), scale.y(549), scale.width(583), scale.height(340))
       
// Snap
local snap = gamegear_surface.add_artwork("snap", scale.x(870), scale.y(553), scale.width(435), scale.height(324))
snap.trigger = Transition.EndNavigation
snap.preserve_aspect_ratio=false

// Scanlines
local scanlines
scanlines = gamegear_surface.add_image("scanlines.png", scale.x(800), scale.y(450), scale.width(622), scale.height(480) )
scanlines.preserve_aspect_ratio = true
scanlines.alpha=160 

// Gamegear Body
local gamegear_overlay = gamegear_surface.add_image("gamegear.png", scale.x(209), scale.y(346), scale.width(1430), scale.height(820))    
 

/////////////////////////////////////////////////////
//                  Positioning
/////////////////////////////////////////////////////
    
stuart_hall.x= scale.x(-70,"right",stuart_hall,null,"center")   
stuart_hall.y= scale.y(-295,"center",stuart_hall,null,"center") 
    
gpk1.x = scale.x(-15,"right",gpk1,stuart_hall_cover,"right")
gpk1.y = scale.y(200,"center",gpk1,stuart_hall_cover,"center") 
gpk2.x = scale.x(-920,"right",gpk2,stuart_hall_cover,"right")
gpk2.y = scale.y(-250,"center",gpk2,stuart_hall_cover,"center") 
gpk3.x = scale.x(-690,"right",gpk2,stuart_hall_cover,"right")
gpk3.y = scale.y(100,"center",gpk2,stuart_hall_cover,"center") 
gpk4.x = scale.x(-1000,"right",gpk2,stuart_hall_cover,"right")
gpk4.y = scale.y(-424,"center",gpk2,stuart_hall_cover,"center")
gpk5.x = scale.x(-950,"right",gpk2,stuart_hall_cover,"right")
gpk5.y = scale.y(84,"center",gpk2,stuart_hall_cover,"center")    
  
wheel.x= stretch.x(-150,"right",wheel)
wheel.y= scale.y(-20,"bottom",wheel)
    
nogame_underlay.x=scale.x(0,"middle",nogame_underlay,gamegear_overlay,"middle")
nogame_underlay.y=scale.y(-120,"middle",nogame_underlay,gamegear_overlay,"middle")

snap.x=scale.x(-20,"middle",snap,gamegear_overlay,"middle")
snap.y=scale.y(-110,"center",snap,gamegear_overlay,"center")
   
gamegear_surface.rotation = -5
gamegear_surface.x = scale.x(320,"middle",gamegear_surface)
gamegear_surface.y = scale.y(-220,"top",gamegear_surface)

scanlines.x=scale.x(0,"middle",scanlines,gamegear_overlay,"middle")
scanlines.y=scale.y(-50,"middle",scanlines,gamegear_overlay,"middle")

playtime.y = scale.y(-35,"bottom",playtime)
playtime.x = scale.x(20,"left",playtime)
playtime.rotation = 6
    
bottle_cap.x = scale.x(10,"left")
bottle_cap.y = scale.y(0,"bottom",bottle_cap, playtime,"top")

/////////////////////////////////////////////////////
//                  Visibility
/////////////////////////////////////////////////////

// playtime
if ( config["show_playtime"] == "No" )
{
    playtime.alpha = 0
}
else
{

}

// scanlines
if (config["show_scanlines"] != "Yes" )
{
    scanlines.alpha = 0
}
// wheel
if ( config["show_logos"] != "Yes" )
{ 
    wheel.alpha = 0
}

// gpk
if ( config["show_gpk"] != "Yes" )
{ 
    gpk1.alpha = 0
    gpk2.alpha = 0
    gpk3.alpha = 0
    gpk4.alpha = 0
    gpk5.alpha = 0  
}

        