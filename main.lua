import 'CoreLibs/object'
import 'sequence.lua'

local gfx = playdate.graphics

function bop()
	_sfx:play()
	print("bop", playdate.getCurrentTimeMilliseconds())
end

local _pick_anim_x = sequence.new():from(150):sleep(0.4):to(50, 0.3, "outCirc"):to(0, 0.5, "outExpo"):start()
local _pick_anim_y = sequence.new():from(-240):sleep(0.4):to(0, 0.3, "inQuad"):callback(bop):to(-30, 0.2, "outBack"):to(0, 0.5, "outBounce"):start()

local _pack_anim_x = sequence.new():from(150):sleep(0.2):to(50, 0.3, "outCirc"):to(0, 0.2, "outExpo"):start()
local _pack_anim_y = sequence.new():from(-240):sleep(0.2):to(0, 0.3, "inQuad"):callback(bop):to(-30, 0.2, "outBack"):to(0, 0.5, "outBounce"):start()

local _pup_anim_x = sequence.new()
local _pup_anim_y = sequence.new():from(-240):to(0, 0.5, "outBack"):callback(bop):start()

local _background = gfx.image.new( "files/background" )
local _pick = gfx.image.new( "files/pick" )
local _pack = gfx.image.new( "files/pack" )
local _pup = gfx.image.new( "files/pup" )

local _crash = sequence.new()
	:from( 240)
	:to( 0, 2.0,"outQuad")
	:callback(function() print("reached high") end)
	:to( 240, 0.6,"outBounce")
	:callback(function() print("crash") end)
	:loop()
	:start()

_sfx = playdate.sound.sampleplayer.new("files/bop")

function playdate.update()
	sequence.update()

	_background:draw(0,0)
	_pick:draw(100 + _pick_anim_x:get(), _pick_anim_y:get())
	_pack:draw(100 + _pack_anim_x:get(), _pack_anim_y:get())
	_pup:draw(100 + _pup_anim_x:get(), _pup_anim_y:get())

	gfx.fillRect(10, _crash:get()-10, 10, 10)


	if playdate.buttonJustPressed(playdate.kButtonA) then
		_pick_anim_x:restart()
		_pick_anim_y:restart()
		_pack_anim_x:restart()
		_pack_anim_y:restart()
		_pup_anim_x:restart()
		_pup_anim_y:restart()
	end
end