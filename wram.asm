; incsrc "hardware_registers.asm"

; Constants:
!Bank_0C = $0C
!Bank_7E = $7E
!Bank_7F = $7F

ORG $7E0000

; scratch RAM
; TODO: eventually create a label for each purpose
; TODO: Only 8A-8F not done
; TODO: $00XX
skip 16

; === $7E0010 ===
; 1 byte
; non-zero during game loop
; set to zero after game loop
; must be non-zero to start game loop
; set to non-zero at end of V-blank
LagFlag_10: skip 1

; === $7E0011 ===
; 1 byte
; the ID of the currently queued IRQ
; for areas that use multiple IRQs, this value distinguishes them
IRQType_11: skip 1

; === $7E0012 ===
; 1 byte
; stripe image ID to draw
; index into a list of pointers to stripe images to draw
; must be divisible by 3 or it will draw garbage
; if this value is zero, the address points to the stripe image ram buffer
StripeImage_12: skip 1

; === $7E0013 ===
; 1 byte
; frame counter
; increments for every frame of execution
; not incremented during lag frames
Frame_13: skip 1

; === $7E0014 ===
; 1 byte
; frame counter
; increments for every frame of execution when gameplay is not paused or frozen
; not incremented during lag frames
Frame_14: skip 1

; === $7E0015 ===
; 1 byte
; controller data for the currently active player
; byetudlr
; |||||||+ set if right on the dpad was pressed this frame
; ||||||+- set if left on the dpad was pressed this frame
; |||||+-- set if down on the dpad was pressed this frame
; ||||+--- set if up on the dpad was pressed this frame
; |||+---- set if the start button was pressed this frame
; ||+----- set if the select button was pressed this frame
; |+------ set if the Y button was pressed this frame
; +------- set if the A or B button were pressed this frame
byetudlrHold_15: skip 1
; Valid values
!ButB = %10000000
!ButY = %01000000
!ButSelect = %00100000
!ButStart = %00010000
!DpadUp = %00001000
!DpadDown = %00000100
!DpadLeft = %00000010
!DpadRight = %00000001

; === $7E0016 ===
; 1 byte
; controller data for the currently active player
; byetudlr
; |||||||+ set if right on the dpad is held this frame
; ||||||+- set if left on the dpad is held this frame
; |||||+-- set if down on the dpad is held this frame
; ||||+--- set if up on the dpad is held this frame
; |||+---- set if the start button is held this frame
; ||+----- set if the select button is held this frame
; |+------ set if the Y button is held this frame
; +------- set if the B button is held this frame
byetudlrPress_16: skip 1
; Valid values
!ButB = %10000000
!ButY = %01000000
!ButSelect = %00100000
!ButStart = %00010000
!DpadUp = %00001000
!DpadDown = %00000100
!DpadLeft = %00000010
!DpadRight = %00000001

; === $7E0017 ===
; 1 byte
; controller data for the currently active player
; axlr0000
; ||||++++ always 0
; |||+---- set if the R button was pressed this frame
; ||+----- set if the L button was pressed this frame
; |+------ set if the X button was pressed this frame
; +------- set if the A button was pressed this frame
axlr0000Hold_17: skip 1
; Valid values
!ButA = %10000000
!ButX = %01000000
!ButL = %00100000
!ButR = %00010000

; === $7E0018 ===
; 1 byte
; controller data for the currently active player
; axlr0000
; ||||++++ always 0
; |||+---- set if the R button is held this frame
; ||+----- set if the L button is held this frame
; |+------ set if the X button is held this frame
; +------- set if the A button is held this frame
axlr0000Press_18: skip 1
; Valid values
!ButA = %10000000
!ButX = %01000000
!ButL = %00100000
!ButR = %00010000

; === $7E0019 ===
; 1 byte
; the player's current powerup status
Powerup_19: skip 1
; Valid values
!PowerupSmall_00 = 0
!PowerupBig_01 = 1
!PowerupCape_02 = 2
!PowerupFlower_03 = 3

; === $7E001A ===
; 2 bytes
; the horizontal scroll value for background layer 1
; value buffer for PPU register $210D, BG1HOFS
Layer1XPos_1A: skip 2

; === $7E001C ===
; 2 bytes
; the vertical scroll value for background layer 1
; value buffer for PPU register $210E, BG1VOFS
Layer1YPos_1C: skip 2

; === $7E001E ===
; 2 bytes
; the horizontal scroll value for background layer 2
; value buffer for PPU register $210F, BG2HOFS
Layer2XPos_1E: skip 2

; === $7E0020 ===
; 2 bytes
; the vertical scroll value for background layer 2
; value buffer for PPU register $2110, BG2VOFS
Layer2YPos_20: skip 2

; === $7E0022 ===
; 2 bytes
; the horizontal scroll value for background layer 3
; value buffer for PPU register $2111, BG3HOFS
Layer3XPos_22: skip 2

; === $7E0024 ===
; 2 bytes
; the vertical scroll value for background layer 3
; value buffer for PPU register $2112, BG3VOFS
Layer3YPos_24: skip 2

; === $7E0026 ===
; 2 bytes
; the horizontal difference between the two interactive layers
; the difference between layer 1 and layer 2 or 3 depending on the level mode
LayerXDiff_26: skip 2

; === $7E0028 ===
; 2 bytes
; the vertical difference between the two interactive layers
; the difference between layer 1 and layer 2 or 3 depending on the level mode
LayerYDiff_28: skip 2

; === $7E002A ===
; 2 bytes
; the horizontal co-ordinate of the mode 7 fixed point
; the value stored here is #$0080 more than the PPU register
; value buffer for PPU register $211F, M7X
Mode7CenterX_2A: skip 2

; === $7E002C ===
; 2 bytes
; the vertical co-ordinate of the mode 7 fixed point
; the value stored here is #$0080 more than the PPU register
; value buffer for PPU register $2120, M7Y
Mode7CenterY_2C: skip 2

; === $7E002E ===
; 2 bytes
; the value of the A parameter for the mode 7 transformation matrix
; value buffer for PPU register $211B, M7A
Mode7ParamA_2E: skip 2

; === $7E0030 ===
; 2 bytes
; the value of the B parameter for the mode 7 transformation matrix
; value buffer for PPU register $211C, M7B
Mode7ParamB_30: skip 2

; === $7E0032 ===
; 2 bytes
; the value of the C parameter for the mode 7 transformation matrix
; value buffer for PPU register $211D, M7C
Mode7ParamC_32: skip 2

; === $7E0034 ===
; 2 bytes
; the value of the D parameter for the mode 7 transformation matrix
; value buffer for PPU register $211E, M7D
Mode7ParamD_34: skip 2

; === $7E0036 ===
; 2 bytes
; the value of an angle, where #$0200 marks a complete circle
; used in calculation of mode 7 parameters, and in brown swinging platforms
Mode7Angle_36: skip 2

; === $7E0038 ===
; 1 byte
; the value of horizontal scaling, where #$20 marks the identity
; used in calculation of mode 7 parameters
; lower values result in higher scaling and vis-versa
Mode7XScale_38: skip 1

; === $7E0039 ===
; 1 byte
; the value of vertical scaling, where #$20 marks the identity
; used in calculation of mode 7 parameters
; lower values result in higher scaling and vis-versa
Mode7YScale_39: skip 1

; === $7E003A ===
; 2 bytes
; the horizontal scroll value for the mode 7 background layer
; value buffer for PPU register $210D, BG1HOFS
Mode7XPos_3A: skip 2

; === $7E003C ===
; 2 bytes
; the vertical scroll value for the mode 7 background layer
; value buffer for PPU register $210E, BG1VOFS
Mode7YPos_3C: skip 2

; === $7E003E ===
; 1 byte
; the background mode and layer character size settings
; value buffer for PPU register $2105, BGMODE
; 4321pmmm
; |||||+++ the background mode (0-7)
; ||||+--- set if background layer 3 has high priority
; ++++---- set if background layer 1/2/3/4 has 16x16 characters, else 8x8
MainBGMode_3E: skip 1

; === $7E003F ===
; 1 byte
; index of the OBJ that should take highest priority
; value buffer for PPU register $2102, OAMADDL
; highest bit of $2103, OAMADDH, is set automatically
OAMAddress_3F: skip 1

; === $7E0040 ===
; 1 byte
; color math settings
; value buffer for PPU register $2131, CGADSUB
; shbo4321
; ||++++++ set if background layer 1/2/3/4/OBJ/back color should participate in color math
; |+------ set if color math result should be halved (e.g. average)
; +------- set if subtract subscreens, else add
ColorSettings_40: skip 1

; === $7E0041 ===
; 1 byte
; window selection settings for background layers 1 and 2
; value buffer for PPU register $2123, W12SEL
; 2i1i2i1i
; |||||||+ background layer 1, in/out bit for window 1
; ||||||+- background layer 1, enable bit for window 1
; |||||+-- background layer 1, in/out bit for window 2
; ||||+--- background layer 1, enable bit for window 2
; |||+---- background layer 2, in/out bit for window 1
; ||+----- background layer 2, enable bit for window 1
; |+------ background layer 2, in/out bit for window 2
; +------- background layer 2, enable bit for window 2
Layer12Window_41: skip 1

; === $7E0042 ===
; 1 byte
; window selection settings for background layers 3 and 4
; value buffer for PPU register $2124, W34SEL
; 2i1i2i1i
; |||||||+ background layer 3, in/out bit for window 1
; ||||||+- background layer 3, enable bit for window 1
; |||||+-- background layer 3, in/out bit for window 2
; ||||+--- background layer 3, enable bit for window 2
; |||+---- background layer 4, in/out bit for window 1
; ||+----- background layer 4, enable bit for window 1
; |+------ background layer 4, in/out bit for window 2
; +------- background layer 4, enable bit for window 2
Layer34Window_42: skip 1

; === $7E0043 ===
; 1 byte
; window selection settings for OBJ layer and color window
; value buffer for PPU register $2125, WOBJSEL
; 2i1i2i1i
; |||||||+ OBJ layer, in/out bit for window 1
; ||||||+- OBJ layer, enable bit for window 1
; |||||+-- OBJ layer, in/out bit for window 2
; ||||+--- OBJ layer, enable bit for window 2
; |||+---- color window, in/out bit for window 1
; ||+----- color window, enable bit for window 1
; |+------ color window, in/out bit for window 2
; +------- color window, enable bit for window 2
OBJCWWindow_43: skip 1

; === $7E0044 ===
; 1 byte
; color math enable and selection switch
; value buffer for PPU register $2130, CGSWSEL
; mmss--fd
; ||||  |+ set if direct color is enabled
; ||||  +- set for color math between subscreens, clear for fixed color math
; ||++---- color window sub screen (00 = on, 01 = inside, 10 = outside, 11 = off)
; ++------ color window main screen (00 = on, 01 = inside, 10 = outside, 11 = off)
ColorAddition_44: skip 1

; === $7E0045 ===
; 2 bytes
; In horizontal levels:
;     the X coordinate (in 16x16 tiles) of the
;     left edge of currently loaded Layer 1 tilemap data
; In vertical levels:
;     the Y coordinate (in 16x16 tiles) of the
;     top edge of currently loaded Layer 1 tilemap data
Layer1TileUp_45: skip 2

; === $7E0047 ===
; 2 bytes
; In horizontal levels:
;     the X coordinate (in 16x16 tiles) of the
;     right edge of currently loaded Layer 1 tilemap data
; In vertical levels:
;     the Y coordinate (in 16x16 tiles) of the
;     bottom edge of currently loaded Layer 1 tilemap data
Layer1TileDown_47: skip 2

; === $7E0049 ===
; 2 bytes
; In horizontal levels:
;     the X coordinate (in 16x16 tiles) of the
;     left edge of currently loaded Layer 2 tilemap data
; In vertical levels:
;     the Y coordinate (in 16x16 tiles) of the
;     top edge of currently loaded Layer 2 tilemap data
Layer2TileUp_49: skip 2

; === $7E004B ===
; 2 bytes
; In horizontal levels:
;     the X coordinate (in 16x16 tiles) of the
;     right edge of currently loaded Layer 2 tilemap data
; In vertical levels:
;     the Y coordinate (in 16x16 tiles) of the
;     bottom edge of currently loaded Layer 2 tilemap data
Layer2TileDown_4B: skip 2

; === $7E004D ===
; 2 bytes
; In horizontal levels:
;     the X coordinate of Layer 1 when a column of tiles
;     was last uploaded to VRAM via scrolling left
; In vertical levels:
;     the Y coordinate of Layer 1 when a column of tiles
;     was last uploaded to VRAM via scrolling up
Layer1PrevTileUp_4D: skip 2

; === $7E004F ===
; 2 bytes
; In horizontal levels:
;     the X coordinate of Layer 1 when a column of tiles
;     was last uploaded to VRAM via scrolling right
; In vertical levels:
;     the Y coordinate of Layer 1 when a column of tiles
;     was last uploaded to VRAM via scrolling down
Layer1PrevTileDown_4F: skip 2

; === $7E0051 ===
; 2 bytes
; In horizontal levels:
;     the X coordinate of Layer 2 when a column of tiles
;     was last uploaded to VRAM via scrolling left
; In vertical levels:
;     the Y coordinate of Layer 2 when a column of tiles
;     was last uploaded to VRAM via scrolling up
Layer2PrevTileUp_51: skip 2

; === $7E0053 ===
; 2 bytes
; In horizontal levels:
;     the X coordinate of Layer 2 when a column of tiles
;     was last uploaded to VRAM via scrolling right
; In vertical levels:
;     the Y coordinate of Layer 2 when a column of tiles
;     was last uploaded to VRAM via scrolling down
Layer2PrevTileDown_53: skip 2

; === $7E0055 ===
; 1 byte
; Which direction Layer 1 has scrolled
; used for handling camera behavior and spawning sprites
Layer1ScrollDir_55: skip 1
; Valid values
!ScrollLeftUp_00 = 0
!ScrollLoading_01 = 1
!ScrollRightDown_02 = 2
!ScrollRightDown_0202 = $0202

; === $7E0056 ===
; 1 byte
; Which direction Layer 2 has scrolled
; used for handling camera behavior
Layer2ScrollDir_56: skip 1
!ScrollLeftUp_00 = 0
!ScrollRightDown_02 = 2

; === $7E0057 ===
; 1 byte
; Position of a 16x16 tile within a screen
; Used during level loading
LevelLoadPos_57: skip 1

; === $7E0058 ===
; 1 byte
; unused
skip 1

; === $7E0059 ===
; 1 byte
; Size or extended type of the currently loading object
LvlLoadObjSize_59: skip 1

; === $7E005A ===
; 1 byte
; Object number of the currently loading object
LvlLoadObjNo_5A: skip 1

; === $7E005B ===
; 1 byte
; Level type properties
; id----21
; ||    |+ Layer 1 is vertical
; ||    +- Layer 2 is vertical
; |+------ set to disable interaction with Layer 1
; +------- set to enable interaction with Layer 2
ScreenMode_5B: skip 1
; Valid values
!Layer1Vert_01 = %01
!Layer2Vert_02 = %10
!Layer12Vert_03 = %11
!DisableL1Int_40 = %01000000
!EnableL2Int_80 = %10000000

; === $7E005C ===
; 1 byte
; unused
skip 1

; === $7E005D ===
; 1 byte
; Number of screens in a level
; Set to -1 during Ludwig and Reznor battles, which represents 1.5
LevelScreens_5D: skip 1

; === $7E005E ===
; 1 byte
; In horizontal levels: the last screen of the level (stop scrolling right)
LastScreenHoriz_5E: skip 1

; === $7E005F ===
; 1 byte
; In vertical levels: the last screen of the level (stop scrolling down)
LastScreenVert_5F: skip 1

; === $7E0060 ===
; 4 bytes
; unused
skip 4

; === $7E0064 ===
; 1 byte
; Default properties for all objects
; yxppccct
; |||||||+ 9th bit of tile number
; ||||+++- palette
; ||++---- object priority
; |+------ x flip
; +------- y flip
SpriteYXPPCCCT_64: skip 1
; Valid values
!Priority0_00 = %000000
!Priority1_10 = %010000
!Priority2_20 = %100000
!Priority3_30 = %110000
!XFlip_40 = %01000000
!YFlip_80 = %10000000

; FIXME:
; === $7E0065 ===
; 3 bytes
; pointer to Layer 1 level data
Layer1DataPtr_65:

; === $7E0065 ===
; 2 bytes
; position of the currently loading line of staff roll text
StaffRollLinePos_65: skip 2

; === $7E0067 ===
; 1 byte
; current line of the staff roll being drawn
StaffRollCurLine_67: skip 1

; === $7E0068 ===
; 3 bytes
; pointer to Layer 2 level data
Layer2DataPtr_68: skip 3

; === $7E006B ===
; 3 bytes
; pointer to Layer 1 Map16 data
Map16LowPtr_6B: skip 3

; === $7E006E ===
; 3 bytes
; pointer to Layer 2 Map16 data
Map16HighPtr_6E: skip 3

; === $7E0071 ===
; 1 byte
; Current player animation that blocks player input
PlayerAnimation_71: skip 1
; Valid values
!AniDefault_00 = 0
!AniHurt_01 = 1
!AniGrowing_02 = 2
!AniGetCape_03 = 3
!AniGetFire_04 = 4
!AniEnterHPipe_05 = 5
!AniEnterVPipe_06 = 6
!AniCannonPipe_07 = 7
!AniYoshiHeaven_08 = 8
!AniDeath_09 = 9
!AniEnterCastle_0A = 10
!AniFrozen_0B = 11
!AniCastleCutscene_0C = 12
!AniDoor_0D = 13

; === $7E0072 ===
; 1 byte
; set if player is not on the ground
PlayerInAir_72: skip 1
; Valid values
!PlayerAir_Jump = 11 ; normal jump or swimming in water level
!PlayerAir_Takeoff = 12 ; pspeed jump
!PlayerAir_Falling = 36 ; descending or swimming in non-water level

; === $7E0073 ===
; 1 byte
; set if player is ducking
PlayerIsDucking_73: skip 1
; Valid values
!PlayerDuck_Duck = 4

; === $7E0074 ===
; 1 byte
; set if player is climbing
; n--shbtc
; |  ||||+ center collision
; |  |||+- top collision
; |  ||+-- bottom collision
; |  |+--- top horizontal collision
; |  +---- bottom horizontal collision
; +------- can climb diagonally (net vs vine)
PlayerClimb_74: skip 1
; Valid values
!PlayerClimb_Center = %00001
!PlayerClimb_Top = %00010
!PlayerClimb_Bottom = %00100
!PlayerClimb_SideTop = %01000
!PlayerClimb_SideBottom = %10000
!PlayerClimb_Diagonally = %10000000

; === $7E0075 ===
; 1 byte
; set if player is in water
PlayerInWater_75: skip 1

; === $7E0076 ===
; 1 byte
; direction player is facing
PlayerDir_76: skip 1
; Valid values
!PlayerDir_Left = 0
!PlayerDir_Right = 1

; === $7E0077 ===
; 1 byte
; flags for player collision with blocks
; s--cudlr
; |  ||||+ collision on right side
; |  |||+- collision on left side
; |  ||+-- collision on bottom
; |  |+--- collision on top
; |  +---- collision inside
; +------- collision with edge of screen
PlayerBlocked_77: skip 1
; Valid values
!Block_Right_01 = %00001
!Block_Left_02 = %00010
!Block_Sides_03 = %00011
!Block_Bottom_04 = %00100
!Block_Top_08 = %01000
!Block_Inside_10 = %10000
!Block_Y_1C = %11100
!Block_Screen_80 = %10000000

; === $7E0078 ===
; 1 byte
; bitfield to hide certain tiles that make up the player
; sabcxylu
; |||||||+ upper half of body
; ||||||+- lower half of body
; ||||++-- various extra smaller tiles
; |||+---- cape tile
; |++----- various other cape tiles
; +------- don't decrement star timer (used with brown swinging platforms)
PlayerHiddenTiles_78: skip 1
; Valid values
!Hide_None_00 = %00000000
!Hide_Body_03 = %00000011
!Hide_Extra_0C = %00001100
!Hide_Cape_10 = %00010000
!Hide_CapeX1_20 = %00100000
!Hide_CapeX2_40 = %01000000
!Hide_All_7F = %01111111
!Hide_PauseStar_80 = %10000000
!Hide_AllStar_FF = %11111111

; === $7E0079 ===
; 1 byte
WRAM_00_79: skip 1

; === $7E007A ===
; 2 bytes
; 4.12 fixed point player horizontal speed (pixels per frame)
; while all 16 bits are used for acceleration, only the
; upper 8 bits are used for position calculation
PlayerXSubpeed_7A:
PlayerXSpeed_7A: skip 1
PlayerXSpeed_7B: skip 1

; === $7E007C ===
; 2 bytes
; 4.12 fixed point player vertical speed (pixels per frame)
; while all 16 bits are used for acceleration, only the
; upper 8 bits are used for position calculation
Unused_7C: skip 1
PlayerYSpeed_7D: skip 1

; === $7E007E ===
; 2 bytes
; player horizontal position relative to the screen boundary
PlayerXPosScrRel_7E: skip 2

; === $7E0080 ===
; 2 bytes
; player horizontal position relative to the screen boundary
PlayerYPosScrRel_80: skip 2

; === $7E0082 ===
; 3 bytes
; pointer to various slope data
; changes with the level tileset
SlopesPtr_82: skip 3

; === $7E0085 ===
; 1 byte
; set if the level is a completely underwater level
LevelIsWater_85: skip 1

; === $7E0086 ===
; 1 byte
; set if the level is slippery
LevelIsSlippery_86: skip 1

; === $7E0087 ===
; 1 byte
; unused
skip 1

; === $7E0088 ===
; 1 byte
; timer that controls how long the animation is
; for entering/exiting a pipe
PipeTimer_88:

; === $7E0088 ===
; 1 byte
; index into no yoshi intro auto input
NoYoshiInputIndex_88:

; === $7E0088 ===
; 1 byte
; timer for castle cutscene auto input (how long each input lasts)
CutsceneInputTimer_88: skip 1

; === $7E0089 ===
; 1 byte
; which pipe animation to display
PlayerPipeAction_89:
; Valid values
!PlayerPipe_EnterRight = 0
!PlayerPipe_EnterLeft = 1
!PlayerPipe_EnterDown = 2
!PlayerPipe_EnterUp = 3
!PlayerPipe_ExitLeft = 4
!PlayerPipe_ExitRight = 5
!PlayerPipe_ExitUp = 6
!PlayerPipe_ExitDown = 7

; === $7E0089 ===
; 1 byte
; timer for no yoshi intro auto input (how long each input lasts)
NoYoshiInputTimer_89: skip 1

;;; TODO $8A - $8F:

; === $7E008A ===
; 1 byte
; temporary location for player Y speed
; used when calculating player speed when running on a wall
TempPlayerYSpeed_8A:

; === $7E008A ===
; 2 bytes
; running sum for calculating the checksum of save files
PartialChecksum_8A:

; === $7E008A ===
; 1 byte
; number of options in the current menu
MaxMenuOptions_8A:

; === $7E008A ===
; 3 bytes
; pointer to the current position within compressed graphics data
GraphicsCompPtr_8A:

; === $7E008A ===
; 1 byte
; which player interaction points are in water
; ---shbtc
;    ||||+ center collision
;    |||+- top collision
;    ||+-- bottom collision
;    |+--- top horizontal collision
;    +---- bottom horizontal collision
InteractionPtsInWater_8A:

; === $7E008A ===
; 1 byte
; GFX file decompression
; 24-bit pointer to the current position in the compressed data
GFXFilePtr_8A: skip 1

; === $7E008B ===
; 1 byte
; which player interaction points are on a climbable tile
; ---shbtc
;    ||||+ center collision
;    |||+- top collision
;    ||+-- bottom collision
;    |+--- top horizontal collision
;    +---- bottom horizontal collision
InteractionPtsClimbable_8B:

; === $7E008B ===
; 1 byte
; Onscreen Y position of the current tile for the player's overworld sprite
OWScreenYCurrentTile_8B: skip 1

; === $7E008C ===
; 1 byte
; which side of a block the current player interaction point is touching
PlayerBlockXSide_8C:

; === $7E008C ===
; 1 byte
; Counter for tiles of the player's overworld sprite
OWTileCount_8C: skip 1

; === $7E008D ===
; 3 bytes
; pointer to the current position within decompressed graphics data
GraphicsUncompPtr_8D:

; === $7E008D ===
; 1 byte
; temporary copy of PlayerIsOnGround
; ------21
;       |+ set if player standing on Layer 1
;       +- set if player standing on Layer 2
TempPlayerGround_8D: skip 1

; === $7E008E ===
; 1 byte
; temporary copy of ScreenMode
; Level type properties
; id----21
; ||    |+ Layer 1 is vertical
; ||    +- Layer 2 is vertical
; |+------ set to disable interaction with Layer 1
; +------- set to enable interaction with Layer 2
TempScreenMode_8E: skip 1

; === $7E008F ===
; 1 byte
; temporary copy of PlayerInAir
TempPlayerAir_8F:

; === $7E008F ===
; 1 byte
; index into castle cutscene auto input
CutsceneInputIndex_8F: skip 1

; === $7E0090 ===
; 1 byte
; vertical position of the player within a block
; relative to the player's feet
PlayerYPosBlock_90: skip 1

; === $7E0091 ===
; 1 byte
; vertical position of the player's interaction point within a block
PlayerBlockMoveY_91: skip 1

; === $7E0092 ===
; 1 byte
; horizontal position of the player within a block
; relative to the center of the player
PlayerXPosBlock_92: skip 1

; === $7E0093 ===
; 1 byte
; which side of a tile the player is currently within
PlayerBlockXSide_93: skip 1

; === $7E0094 ===
; 2 bytes
; horizontal position of the player within the level
; forward calculation for the next frame
PlayerXPos_94: skip 2

; === $7E0096 ===
; 2 bytes
; vertical position of the player within the level
; forward calculation for the next frame
PlayerYPos_96: skip 2

; === $7E0098 ===
; 2 bytes
; vertical position of the currently processing player interaction point
InteractionPtYPos_98: skip 2

; === $7E009A ===
; 2 bytes
; horizontal position of the currently processing player interaction point
InteractionPtXPos_9A: skip 2

; === $7E009C ===
; 1 byte
; a Map16 tile to draw to the screen
TileGenerate_9C: skip 1
; Valid values
!GenCollectEmpty = 1 ; sets item memory
!GenEmpty = 2
!GenVine = 3
!GenBush = 4
!GenTurningBlock = 5
!GenCoin = 6
!GenMushStalk = 7
!GenMoleHole = 8
!GenSolidEmpty = 9
!GenTurnMulticoin = 10
!GenQMulticoin = 11
!GenTurnBlock = 12
!GenUsedBlock = 13
!GenNoteBlock = 14
!GenNoteUnused = 15
!GenNoteAllSides = 16
!GenTurnBounce = 17
!GenRoulette = 18
!GenOnOff = 19
!GenPipeLeft = 20
!GenPipeRight = 21
!GenCollectUsed = 22 ; sets item memory
!GenCollectCorrect = 23 ; sets item memory
!GenCollectDragon = 24 ; sets item memory
!GenNetDoorEmpty = 25
!GenNetDoorClosed = 26
!GenFlatSwitch = 27

; === $7E009D ===
; 1 byte
; locks most animations and movements when set
SpriteLock_9D: skip 1

; === $7E009E ===
; 12 bytes
; sprite ID table
SpriteNumber_9E: skip 12
; Valid values
!Lakitu_1E = $1E
!Yoshi_35 = $35
!SmallOrangePlat_5D = $5D
!Rope_64 = $64
!ChainsawUp_65 = $65
!FuzzyLine_68 = $68
!Peach_7C = $7C
!ChangingItem_81 = $81
!BonusGame_7C = $82 ; TODO: _82
!CharginChuck_91 = $91
!SplittinChuck_92 = $92
!BouncinChuck_93 = $93
!BowserBall_A1 = $A1
!Reznor_A9 = $A9

; === $7E00AA ===
; 12 bytes
; sprite vertical speed table
SpriteYSpeed_AA: skip 12

; === $7E00B6 ===
; 12 bytes
; sprite horizontal speed table
SpriteXSpeed_B6: skip 12

; === $7E00C2 ===
; 12 bytes
; various sprite properties table
SpritePhase_C2: skip 12

; === $7E00CE ===
; 3 bytes
; pointer to the level's sprite data
SpriteDataPtr_CE: skip 3

; === $7E00D1 ===
; 2 bytes
; horizontal position of the player within the level
PlayerXPosMirror_D1: skip 2

; === $7E00D3 ===
; 2 bytes
; vertical position of the player within the level
PlayerYPosMirror_D3: skip 2

; === $7E00D5 ===
; 3 bytes
; pointer to the segment data of currently processing Wiggler
WigglerSegmentPtr_D5: skip 3

; === $7E00D8 ===
; 12 bytes
; sprite vertical position table
; lower 8 bits
SpriteYPosLow_D8: skip 12

; === $7E00E4 ===
; 12 bytes
; sprite horizontal position table
; lower 8 bits
SpriteXPosLow_E4: skip 12

; === $7E00F0 ===
; 16 bytes
; unused
skip 16

; === $7E0100 ===
; 1 byte
; the current game mode
GameMode_0100: skip 1
; Valid values
!LoadPresents_00 = 0
!Presents_01 = 1
!FadeToTitleScreen_02 = 2
!LoadTitleScreen_03 = 3
!PrepareTitleScreen_04 = 4
!FadeInTitleScreen_05 = 5
!SpotlightTitleScreen_06 = 6
!TitleScreen_07 = 7
!FileSelect_08 = 8
!FileDelete_09 = 9
!PlayerSelect_0A = 10
!FadeToOverworld_0B = 11
!LoadOverworld_0C = 12
!FadeInOverworld_0D = 13
!Overworld_0E = 14
!FadeToLevel_0F = 15
!FadeLevelBlack_10 = 16
!LoadLevel_11 = 17
!PrepareLevel_12 = 18
!FadeInLevel_13 = 19
!Level_14 = 20
!FadeToGameOver_15 = 21
!LoadGameOver_16 = 22
!GameOver_17 = 23
!FadeToCutscene_18 = 24
!LoadCutscene_19 = 25
!FadeInCutscene_1A = 26
!Cutscene_1B = 27
!FadeToThankYou_1C = 28
!LoadThankYou_1D = 29
!FadeInThankYou_1E = 30
!ThankYou_1F = 31
!FadeToEnemyList_20 = 32
!LoadEnemyList_21 = 33
!FadeInEnemyList_22 = 34
!EnemyList_23 = 35
!FadeToTheEnd_24 = 36
!LoadTheEnd_25 = 37
!FadeInTheEnd_26 = 38
!TheEnd_27 = 39

; === $7E0101 ===
; 4 bytes
; the four currently loaded sprite graphics files loaded in VRAM
SpriteGFXFile_0101: skip 4

; === $7E0105 ===
; 4 bytes
; the four currently loaded sprite graphics files loaded in VRAM
BackgroundGFXFile_0105: skip 4

; === $7E0109 ===
; 1 byte
; translevel number to load in lieu of the overworld
OverworldOverride_0109: skip 1

; === $7E010A ===
; 1 byte
; the current save file to save to
SaveFile_010A: skip 6

; === $7E0110 ===
; 2 bytes
; timer used for the size of the letterboxing during the credits
; (only used in PAL v1.1)
CreditsLetterbox_0110: skip 1

; $7E0112 - $7E01FF used as stack
skip 238

; === $7E01FF ===
; variable size
; stack starts here and grows down
; ~240 bytes available before Bad Things(TM) happen
StackStart_01FF: skip 1
!StackStart_01FF = $01FF

; === $7E0200 ===
; 512 bytes
; a work RAM buffer of Object Attribute Memory (OAM)
; table 1: object position, tile, and attributes
OAMMirror_0200:

; === $7E0200 ===
; 128 objects
; the lower 8 bits of the object's X position on the screen
OAMTileXPos_0200: skip 1

; === $7E0201 ===
; 128 objects
; the 8 bits of the object's Y position on the screen
; $E0 is just off the bottom of the screen
OAMTileYPos_0201: skip 1

; === $7E0202 ===
; 128 objects
; the lower 8 bits of the tile number that the object uses
OAMTileNo_0202: skip 1

; === $7E0203 ===
; 128 objects
; various properties of the object
; yxppccct
; |||||||+ the higher 1 bit of the tile number the object uses
; ||||+++- the palette that the object uses
; ||++---- the priority that this object has against backgrounds
; |+------ the object is flipped horizontally
; +------- the object is flipped vertically
OAMTileAttr_0203: skip 1
skip 508

; === $7E0400 ===
; 32 bytes
; a work RAM buffer of Object Attribute Memory (OAM)
; table 2: object high X position & size
OAMTileBitSize_0400: skip 32

; === $7E0420 ===
; 128 bytes
; expanded table of object attributes for OAM table 2
; one byte per object
; ------sx
;       |+ the higher 1 bit of the object's X position on the screen
;       +- the size of the object (big or small)
OAMTileSize_0420: skip 128

; === $7E04A0 ===
; 480 bytes
; window left and right positions for each line
; 2 bytes per line
; last 32 lines are seldom used outside of the PAL release
WindowTable_04A0:

; === $7E04A0 ===
; 10 bytes
; HDMA table for background layer 1 position during the
; enemy names credits scenes
; first two entries are for the top half
; (split in two because it can be large)
; last entry for bottom half
CreditsL1HDMATable_04A0: skip 10

; === $7E04AA ===
; 10 bytes
; HDMA table for background layer 2 position during the
; enemy names credits scenes
; first two entries are for the top half
; (split in two because it can be large)
; last entry for bottom half
CreditsL2HDMATable_04AA: skip 10

; === $7E04B4 ===
; 10 bytes
; HDMA table for background layer 3 position during the
; enemy names credits scenes
; first two entries are for the top half
; (split in two because it can be large)
; last entry for bottom half
CreditsL3HDMATable_04B4: skip 460

; === $7E0680 ===
; 1 byte
; which palette table to use
PaletteIndexTable_0680: skip 1
; Valid values
!PaletteTableUse_Dynamic = 0
!PaletteTableUse_Copy = 3
!PaletteTableUse_Main = 6

; === $7E0681 ===
; 1 byte
; the current size of the dynamic palette upload table
DynPaletteIndex_0681: skip 1

; === $7E0682 ===
; 127 bytes
; list of entries of colors to upload to CGRAM
; each entry has a 2 byte header
; header byte 1 = number of bytes to upload in this entry
; header byte 2 = CGRAM word address to upload this entry
; data = the colors to upload
DynPaletteTable_0682: skip 127

; === $7E0701 ===
; 2 bytes
; the fixed color, commonly used for the background
; value buffer for PPU register $2132, COLDATA
BackgroundColor_0701: skip 2

; === $7E0703 ===
; 512 bytes
; a work RAM buffer of the entirety of CGRAM
MainPalette_0703: skip 512

; === $7E0903 ===
; 2 bytes
; copy of the background color
; used during level end palette fade in and out
CopyBGColor_0903: skip 2

; === $7E0905 ===
; 496 bytes
; a copy of almost all of CGRAM, missing the last 8 colors
; used during level end palette fade in and out
; as well as overworld event tile fading animation
CopyPalette_0905: skip 496

; === $7E0AF5 ===
; 1 byte
; mostly unused
; cleared after a boss is beaten
Empty_0AF5: skip 1

; === $7E0AF6 ===
; 352 bytes
; graphics buffer for animated tiles on the overworld
GfxDecompOWAni_0AF6:

; === $7E0AF6 ===
; 256 bytes
; tilemap for Iggy and Larry's rotating platform
IggyLarryPlatInteract_0AF6:

; === $7E0AF6 ===
; 15 bytes
; timer for sprites during credits and castle cutscenes
CreditsSprTimer_0AF6: skip 15

; === $7E0B05 ===
; 15 bytes
; Y speed for sprites during credits and castle cutscenes
; upper 8 bits of 4.12 fixed point in pixels per frame
CreditsSprYSpeed_0B05: skip 15

; === $7E0B14 ===
; 15 bytes
; X speed for sprites during credits and castle cutscenes
; upper 8 bits of 4.12 fixed point in pixels per frame
CreditsSprXSpeed_0B14: skip 15

; === $7E0B23 ===
; 15 bytes
; Y speed fractional part for sprites during credits and castle cutscenes
; lower 8 bits of 4.12 fixed point in pixels per frame
CreditsSprYSubSpd_0B23: skip 15

; === $7E0B32 ===
; 15 bytes
; X speed fractional part for sprites during credits and castle cutscenes
; lower 8 bits of 4.12 fixed point in pixels per frame
CreditsSprXSubSpd_0B32: skip 15

; === $7E0B41 ===
; 15 bytes
; low byte of Y position for sprites during credits and castle cutscenes
CreditsSprYPosLow_0B41: skip 15

; === $7E0B50 ===
; 15 bytes
; low byte of X position for sprites during credits and castle cutscenes
CreditsSprXPosLow_0B50: skip 15

; === $7E0B5F ===
; 15 bytes
; high byte of Y position for sprites during credits and castle cutscenes
CreditsSprYPosHigh_0B5F: skip 15

; === $7E0B6E ===
; 15 bytes
; high byte of X position for sprites during credits and castle cutscenes
CreditsSprXPosHigh_0B6E: skip 15

; === $7E0B7D ===
; 15 bytes
; vertical acceleration for sprites during credits and castle cutscenes
CastleCutExSprAccel_0B7D: skip 15

; === $7E0B8C ===
; 15 bytes
; flag to denote slot taken for sprites during credits and castle cutscenes
CastleCutExSprSlot_0B8C: skip 106

; === $7E0BF6 ===
; 384 bytes
; graphics buffer for OBJ tiles $4A-$4F & $5A-$5F
; includes small pieces of Mario, springboard, sliding Koopa, et al
GfxDecompSP1_0BF6: skip 384

; === $7E0D76 ===
; 2 bytes
; source address of the first of three
; animated 16x16 tiles uploaded this frame
Gfx33SrcAddrA_0D76: skip 2

; === $7E0D78 ===
; 2 bytes
; source address of the second of three
; animated 16x16 tiles uploaded this frame
Gfx33SrcAddrB_0D78: skip 2

; === $7E0D7A ===
; 2 bytes
; source address of the third of three
; animated 16x16 tiles uploaded this frame
Gfx33SrcAddrC_0D7A: skip 2

; === $7E0D7C ===
; 2 bytes
; destination VRAM address of the first of three
; animated 16x16 tiles uploaded this frame
Gfx33DestAddrA_0D7C: skip 2

; === $7E0D7E ===
; 2 bytes
; destination VRAM address of the second of three
; animated 16x16 tiles uploaded this frame
Gfx33DestAddrB_0D7E: skip 2

; === $7E0D80 ===
; 2 bytes
; destination VRAM address of the third of three
; animated 16x16 tiles uploaded this frame
Gfx33DestAddrC_0D80: skip 2

; === $7E0D82 ===
; 2 bytes
; pointer to the player's palette (bank is $00)
PlayerPalPtr_0D82: skip 2

; === $7E0D84 ===
; 1 byte
; number of 8x8 tiles that make up the player
PlayerGfxTileCount_0D84: skip 1

; === $7E0D85 ===
; 20 bytes
; 10 pointers to graphics that make up various parts of
; Mario, Yoshi, cape, and Podoboo
DynGfxTilePtr_0D85: skip 20

; === $7E0D99 ===
; 2 bytes
; pointer to graphics that make up parts of Mario (OBJ tile $7F)
DynGfxTile7FPtr_0D99: skip 2

; === $7E0D9B ===
; 1 byte
; flag to determine which NMI and IRQ code to run for various game modes
IRQNMICommand_0D9B: skip 1
; Valid values
!IRQNMIStandard_00 = 0
!IRQNMICutscenes_01 = 1
!IRQNMIOverworld_02 = 2
!IRQNMIIggyLarry_80 = %10000000
!IRQNMIReznorMortonRoy_C0 = %11000000
!IRQNMIBowser_C1 = %11000001

; === $7E0D9C ===
; 1 byte
; unused
skip 1

ThroughMain_0D9D: skip 1
ThroughSub_0D9E: skip 1
HDMAEnable_0D9F: skip 1
ControllersPresent_0DA0: skip 1
; 7E0DA1 unused
skip 1
byetudlrP1Hold_0DA2: skip 1
byetudlrP2Hold_0DA3: skip 1
axlr0000P1Hold_0DA4: skip 1
axlr0000P2Hold_0DA5: skip 1
byetudlrP1Frame_0DA6: skip 1
byetudlrP2Frame_0DA7: skip 1
axlr0000P1Frame_0DA8: skip 1
axlr0000P2Frame_0DA9: skip 1
byetudlrP1Mask_0DAA: skip 1
byetudlrP2Mask_0DAB: skip 1
axlr0000P1Mask_0DAC: skip 1
axlr0000P2Mask_0DAD: skip 1
Brightness_0DAE: skip 1
MosaicDirection_0DAF: skip 1
MosaicSize_0DB0: skip 1
KeepModeActive_0DB1: skip 1
IsTwoPlayerGame_0DB2: skip 1
CurrentPlayer_0DB3: skip 1
SavedPlayerLives_0DB4: skip 2
SavedPlayerCoins_0DB6: skip 2
SavedPlayerPowerup_0DB7: skip 2
SavedPlayerYoshi_0DBA: skip 2 ;done
SavedPlayerItembox_0DBC: skip 2
PlayerLives_0DBE: skip 1
PlayerCoins_0DBF: skip 1
GreenStarBlockCoins_0DC0: skip 1
CarryYoshiLevels_0DC1: skip 1 ;done
PlayerItembox_0DC2: skip 1
; 7E0DC3 - 7E0DC6 unused
skip 4
OverworldDestXPos_0DC7: skip 2
OverworldDestYPos_0DC9: skip 6
OWPlayerSpeed_0DCF: skip 4
OWPlayerDirection_0DD3: skip 2
LevelExitMode_0DD5: skip 1
PlayerTurnOW_0DD6: skip 2
PlayerSwitching_0DD8: skip 1
; 7E0DD9 unused
skip 1
MusicBackup_0DDA: skip 1
; 7E0DDB - 7E0DDD unused
skip 3
SaveFileDelete_0DDE: skip 1
OWCloudOAMIndex_0DDF: skip 1
OWCloudYSpeed_0DE0: skip 5
OWSpriteNumber_0DE5: skip 16
OWSpriteMisc_0DF5: skip 16
OWSpriteMisc_0E05: skip 16
OWSpriteMisc_0E15: skip 16
OWSpriteMisc_0E25: skip 16
OWSpriteXPosLow_0E35: skip 16
OWSpriteYPosLow_0E45: skip 16
OWSpriteZPosLow_0E55: skip 16
OWSpriteXPosHigh_0E65: skip 16
OWSpriteYPosHigh_0E75: skip 16
OWSpriteZPosHigh_0E85: skip 16 ; unused?
OWSpriteXSpeed_0E95: skip 16
OWSpriteYSpeed_0EA5: skip 16
OWSpriteZSpeed_0EB5: skip 16
OWSpriteXPosSpx_0EC5: skip 16
OWSpriteYPosSpx_0ED5: skip 16 ; unused?
OWSpriteZPosSpx_0EE5: skip 16 ; unused?
KoopaKidActive_0EF5: skip 1
KoopaKidTile_0EF6: skip 1
EnterLevelAuto_0EF7: skip 1
YoshiSavedFlag_0EF8: skip 1 ;done
StatusBar_0EF9: skip 55
InGameTimerFrames_0F30: skip 1
InGameTimerHundreds_0F31: skip 1
InGameTimerTens_0F32: skip 1
InGameTimerOnes_0F33: skip 1
PlayerScore_0F34: skip 6
; 7E0F3A - 7E0F3F unused
skip 6
ScoreIncrement_0F40: skip 2
; 7E0F42 - 7E0F47 unused
skip 6
PlayerBonusStars_0F48: skip 2
ClusterSpriteMisc_0F4A: skip 20
ClusterSpriteMisc_0F5E: skip 20 ; unused
ClusterSpriteMisc_0F72: skip 20
ClusterSpriteMisc_0F86: skip 20
ClusterSpriteMisc_0F9A: skip 20
BooRingAngleLow_0FAE: skip 2
BooRingAngleHigh_0FB0: skip 2
BooRingXPosLow_0FB2: skip 2
BooRingXPosHigh_0FB4: skip 2
BooRingYPosLow_0FB6: skip 2
BooRingYPosHigh_0FB8: skip 2
BooRingOffscreen_0FBA: skip 2
BooRingLoadIndex_0FBC: skip 2
Map16Pointers_0FBE: skip 1024
ItemMemorySetting_13BE: skip 1
Translevel_13BF: skip 2
OverworldLayer1Tile_13C1: skip 2
CurrentSubmap_13C3: skip 2
MoonCounter_13C5: skip 1
CutsceneID_13C6: skip 1
YoshiColor_13C7: skip 1 ;done
; 7E13C8 unused
skip 1
ShowContinueEnd_13C9: skip 1
ShowSavePrompt_13CA: skip 1
UnusedStarCounter_13CB: skip 1
CoinAdder_13CC: skip 1
DisableMidway_13CD: skip 1
MidwayFlag_13CE: skip 1
SkipMidwayCastleIntro_13CF: skip 1
StructureCrushTile_13D0: skip 1
StructureCrushIndex_13D1: skip 1
SwitchPalaceColor_13D2: skip 1
RamLevelReset_13D3:
PauseTimer_13D3: skip 1
PauseFlag_13D4: skip 1
Layer3ScrollType_13D5: skip 1
DrumrollTimer_13D6: skip 1
IntroMarchYPosSpx_13D7: skip 2
OverworldProcess_13D9: skip 1
PlayerXPosSpx_13DA: skip 1
PlayerWalkingPose_13DB: skip 1
PlayerYPosSpx_13DC: skip 1 ; unused
PlayerTurningPose_13DD: skip 1
PlayerOverworldPose_13DE: skip 1
PlayerCapePose_13DF: skip 1
PlayerPose_13E0: skip 1
SlopeType_13E1: skip 1
SpinjumpFireball_13E2: skip 1
WallRunFlag_13E3: skip 1
PlayerPMeter_13E4: skip 1
PlayerPoseLenTimer_13E5: skip 1
; 7E13E6 - 7E13E7 unused
skip 2
CapeInteracts_13E8: skip 1
CapeInteractionXPos_13E9: skip 2
CapeInteractionYPos_13EB: skip 2
PlayerSlopePose_13ED: skip 1 ;done
CurrentSlope_13EE: skip 1
PlayerGroundType_13EF: skip 1
NetDoorDirIndex_13F0: skip 1
VerticalScrollEnabled_13F1: skip 1
; 7E13F2 unused
skip 1
PBalloonFlag_13F3: skip 1 ;done
BonusRoomBlocks_13F4: skip 5
PlayerBehindNet_13F9: skip 1
PlayerCanJumpWater_13FA: skip 1
PlayerIsFrozen_13FB: skip 1
ActiveBoss_13FC: skip 1
CameraIsScrolling_13FD: skip 1
CameraScrollDir_13FE: skip 1
CameraScrollPlayerDir_13FF: skip 1
CameraProperMove_1400: skip 1
CameraScrollTimer_1401: skip 1
NoteBlockActive_1402: skip 1

; === $7E1403 ===
; 1 byte
; which layer 3 tide setting is enabled
Layer3TideSetting_1403: skip 1
; Valid values
!Tide_UpAndDown = 1
!Tide_Stationary = 2

ScreenScrollAtWill_1404: skip 1
DrawYoshiInPipe_1405: skip 1 ;done
BouncingOnBoard_1406: skip 1
FlightPhase_1407: skip 1
NextFlightPhase_1408: skip 1
MaxStageOfFlight_1409: skip 1
Empty_140A: skip 1
; 7E140B - 7E140C unused
skip 2
SpinJumpFlag_140D: skip 1
Layer2Touched_140E: skip 1
ReznorOAMIndex_140F: skip 1
YoshiHasWingsGfx_1410: skip 1 ;done
HorizLayer1Setting_1411: skip 1
VertLayer1Setting_1412: skip 1
HorizLayer2Setting_1413: skip 1
VertLayer2Setting_1414: skip 1
; 7E1415 - 7E1416 unused
skip 2
BackgroundVertOffset_1417: skip 2 ;done
SpriteInPipeMode_1419: skip 1 ;done
SublevelCount_141A: skip 1 ;done
DidPlayBonusGame_141B: skip 1 ;done
SecretGoalTape_141C: skip 1 ;done
ShowMarioStart_141D: skip 1 ;done
YoshiHasWings_141E: skip 1 ;done
DisableNoYoshiIntro_141F: skip 1 ;done
DragonCoinsCollected_1420: skip 1
OneUpCheckpoints_1421: skip 1
DragonCoinsShown_1422: skip 1
SwitchPalacePressed_1423: skip 1
DisplayBonusStars_1424: skip 1
BonusGameFlag_1425: skip 1
MessageBoxTrigger_1426: skip 1
ClownCarImage_1427: skip 1
ClownCarPropeller_1428: skip 1
BowserPalette_1429: skip 1
CameraMoveTrigger_142A: skip 2
CameraLeftBuffer_142C: skip 2
CameraRightBuffer_142E: skip 2
SolidTileStart_1430: skip 1
SolidTileEnd_1431: skip 1
DirectCoinInit_1432: skip 1
SpotlightSize_1433: skip 1
KeyholeTimer_1434: skip 1
KeyholeDirection_1435: skip 1
KeyholeXPos_1436: skip 2
KeyholeYPos_1438: skip 2
UploadMarioStart_143A: skip 1
DeathMessage_143B: skip 1
GameOverAnimation_143C: skip 1
GameOverTimer_143D: skip 1
Layer1ScrollCmd_143E: skip 1
Layer2ScrollCmd_143F: skip 1
Layer1ScrollBits_1440: skip 1
Layer2ScrollBits_1441: skip 1
Layer1ScrollType_1442: skip 1
CutsceneTextTimer_1443:
SelectedStartingZone_1443:
Layer2ScrollType_1443: skip 1
Layer1ScrollTimer_1444: skip 1
Layer2ScrollTimer_1445: skip 1
Layer1ScrollXSpeed_1446: skip 2
Layer1ScrollYSpeed_1448: skip 2
Layer2ScrollXSpeed_144A: skip 2
Layer2ScrollYSpeed_144C: skip 2
Layer1ScrollXPosUpd_144E: skip 2
Layer1ScrollYPosUpd_1450: skip 2
Layer2ScrollXPosUpd_1452: skip 2
Layer2ScrollYPosUpd_1454: skip 2
ScrollLayerIndex_1456: skip 1
CreditsJumpingYoshi_1457: skip 1
Layer3ScrollXSpeed_1458: skip 2
Layer3ScrollYSpeed_145A: skip 2
Layer3ScrollXPosUpd_145C: skip 2
; 7E145E - 7E145F unused
skip 2
Layer3ScroolDir_1460: skip 1
; 7E1461 unused
skip 1
NextLayer1XPos_1462: skip 2
NextLayer1YPos_1464: skip 2
NextLayer2XPos_1466: skip 2
NextLayer2YPos_1468: skip 2
Layer3HorizOffset_146A: skip 2
; 7E146C - 7E146F unused
skip 4
CarryingFlag_1470: skip 1
OnSolidSprite_1471: skip 1
LightTopWinOpenPos_1472: skip 1
; 7E1473 unused
skip 1
LightTopWinClosePos_1474: skip 1
; 7E1475 unused
skip 1
LightBotWinOpenPos_1476: skip 1
; 7E1477 unused
skip 1
LightBotWinClosePos_1478: skip 1
; 7E1479 unused
skip 1
LightWinOpenCalc_147A: skip 1
; 7E147B unused
skip 1
LightWinCloseCalc_147C: skip 1
; 7E147D unused
skip 1
LightWinOpenMove_147E: skip 1
LightWinCloseMove_147F: skip 1
LightLeftWidth_1480: skip 1
LightRightWidth_1481: skip 1
LightSkipInit_1482: skip 1
LightMoveDir_1483: skip 1
LightLeftRelPos_1484: skip 1
LightRightRelPos_1485: skip 1
LightExists_1486: skip 1
; 7E1487 - 7E148A unused
skip 4
RNGCalc_148B: skip 2
RandomNumber_148D: skip 2
CarryingFlagMirror_148F: skip 1
StarTimer_1490: skip 1
SpriteXMovement_1491: skip 1
PlayerPeaceSign_1492: skip 1 ;done
EndLevelTimer_1493: skip 1;done
ColorFadeDir_1494: skip 1 ;done
ColorFadeTimer_1495: skip 1 ;done
PlayerAniTimer_1496: skip 1 ;done
FlashingTimer_1497: skip 1 ;done
PickUpItemTimer_1498: skip 1 ;done
FaceScreenTimer_1499: skip 1 ;done
KickTimer_149A: skip 1 ;done
CyclePaletteTimer_149B: skip 1 ;done
ShootFireTimer_149C: skip 1 ;done
NetDoorTimer_149D: skip 1 ;done
PunchNetTimer_149E: skip 1 ;done
TakeoffTimer_149F: skip 1 ;done
RunTakeoffTimer_14A0: skip 1 ;done
SkidTurnTimer_14A1: skip 1 ;done
CapeAniTimer_14A2: skip 1 ;done
YoshiTongueTimer_14A3: skip 1 ;done
CapePumpTimer_14A4: skip 1 ;done
CapeFloatTimer_14A5: skip 1 ;done
CapeSpinTimer_14A6: skip 1 ;done
ReznorBridgeTimer_14A7: skip 1 ;done
UnusedTimer_14A8: skip 1 ;done
UnusedGroundPoundTimer_14A9: skip 1 ;done
UnusedYoshiWingTimer_14AA: skip 1 ;done
BonusTimer_14AB: skip 1 ;done
; 7E14AC unused
skip 1
TimersStart_14AD: ;done
BlueSwitchTimer_14AD: skip 1 ;done
SilverSwitchTimer_14AE: skip 1 ;done
OnOffSwitch_14AF: skip 1 ;done

LakituCloudTempXPos_14B0:
IggyLarryRotCenterX_14B0:
BrSwingCenterXPos_14B0: skip 1

BowserWaitTimer_14B1: skip 1

BowserAttackTimer_14B2:
LakituCloudTempYPos_14B2:
IggyLarryRotCenterY_14B2:
BrSwingCenterYPos_14B2:
BowserFlyawayCounter_14B2: skip 1

ClownCarTeardropPos_14B3: skip 1

IggyLarryPlatIntXPos_14B4:
BrSwingXDist_14B4:
BowserMusicIndex_14B4: skip 1

BowserHurtState_14B5: skip 1
IggyLarryPlatIntYPos_14B6:
BrSwingYDist_14B6:
BowserSteelieTimer_14B6: skip 1
BowserFireXPos_14B7: skip 1
IggyLarryTempXPos_14B8:
BrSwingPlatXPos_14B8:
BowserAttackType_14B8: skip 2
IggyLarryTempYPos_14BA:
BrSwingPlatYPos_14BA: skip 2
BrSwingRadiusX_14BC: skip 2
; 7E14BE unused
skip 1
BrSwingRadiusY_14BF: skip 2
; 7E14C1 unused
skip 1
BrSwingSine_14C2: skip 2
; 7E14C4 unused
skip 1
BrSwingCosine_14C5: skip 2
; 7E14C7 unused
skip 1


SpriteStatus_14C8: skip 12 ;done
; Valid values
!StatusEmpty_00 = $00
!StatusInit_01 = $01
!StatusFall_02 = $02
!StatusSmush_03 = $03
!StatusSpinkill_04 = $04
!StatusLavA_05 = $05
!StatusCoin_06 = $06
!StatusMouth_07 = $07
!StatusNormal_08 = $08
!StatusCarryable_09 = $09
!StatusKicked_0A = $0A
!StatusCarried_0B = $0B
!StatusPowerup_0C = $0C

SpriteYPosHigh_14D4: skip 12 ;done
SpriteXPosHigh_14E0: skip 12 ;done
SpriteYPosSpx_14EC: skip 12 ;done
SpriteXPosSpx_14F8: skip 12 ;done
Sprite_1504: skip 12 ;done
Sprite_1510: skip 12 ;done
Sprite_151C: skip 12 ;done
Sprite_1528: skip 12 ;done
Sprite_1534: skip 12 ;done
SpriteStun_1540: skip 12 ;done
SpritePlayerContact_154C: skip 12 ;done
SpriteLava_1558: skip 12 ;done
SpriteSprContact_1564: skip 12 ;done
SpriteAnimationTimer_1570: skip 12 ;done
SpriteDir_157C: skip 12 ;done
; Valid values
!SpriteDir_Left = 0
!SpriteDir_Right = 1
SpriteBlocked_1588: skip 12 ;done
; TODO: use YoshiMouthRt_1594 when appropriate
Sprite_1594: skip 12 ;done
SpriteOffscreenX_15A0: skip 12 ;done
SpriteTurnTimer_15AC: skip 12 ;done
SpriteSlope_15B8: skip 12 ;done
SpriteWayOffscreenX_15C4: skip 12 ;done
SpriteOnTongue_15D0: skip 12 ;done
SpriteDisableObjInt_15DC: skip 12 ;done
; 7E15E8 unused
skip 1
CurrentSprite_15E9: skip 1 ;done
SpriteOAMIndex_15EA: skip 12 ;done
SpriteYXPPCCCT_15F6: skip 12 ;done
SpriteAnimation_1602: skip 12 ;done
Sprite_160E: skip 12 ;done
SpriteLoadIndex_161A: skip 12 ;done
SpriteKill_1626: skip 12 ;done
SpriteBehindScene_1632: skip 12 ;done
Sprite_163E: skip 12 ;done
SpriteInLiquid_164A: skip 12 ;done
sSjJcccc_1656: skip 12 ;done
dscccccc_1662: skip 12 ;done
lwcfpppg_166E: skip 12 ;done
dpmksPiS_167A: skip 12 ;done
dnctswye_1686: skip 12 ;done


SpriteMemorySetting_1692: skip 1 ;done
Map16_1693: skip 1 ;done
SpriteBlockOffset_1694: skip 1 ;done
SpriteInterIndex_1695: skip 1 ;done
; 7E1696 unused
skip 1
SpriteStompCounter_1697: skip 1 ;done
CurrentMinorSprite_1698: skip 1 ;done


BounceSprNumber_1699: skip 4 ;done
BounceSprInit_169D: skip 4 ;done
BounceSprYPosLow_16A1: skip 4 ;done
BounceSprXPosLow_16A5: skip 4 ;done
BounceSprYPosHigh_16A9: skip 4 ;done
BounceSprXPosHigh_16AD: skip 4 ;done
BounceSprYSpeed_16B1: skip 4 ;done
BounceSprXSpeed_16B5: skip 4 ;done
BounceSprXPosSpx_16B9: skip 4 ;done
; 7E16BD: unused
skip 4
BounceSprTile_16C1: skip 4 ;done
BounceSprTimer_16C5: skip 4 ;done
BounceSprFlags_16C9: skip 4 ;done


QuakeSprNumber_16CD: skip 4 ;done
QuakeSprXPosLow_16D1: skip 4 ;done
QuakeSprXPosHigh_16D5: skip 4 ;done
QuakeSprYPosLow_16D9: skip 4 ;done
QuakeSprYPosHigh_16DD: skip 4 ;done


ScoreSprNumber_16E1: skip 6 ;done
ScoreSprYPosLow_16E7: skip 6 ;done
ScoreSprXPosLow_16ED: skip 6 ;done
ScoreSprXPosHigh_16F3: skip 6 ;done
ScoreSprYPosHigh_16F9: skip 6 ;done
ScoreSprTimer_16FF: skip 6 ;done
ScoreSprLayer_1705: skip 6 ;done


ExtSprNumber_170B: skip 10 ;done
; Valid values
!EmptyExt_00 = $00
!SmokePuff_01 = $01
!ReznorFireball_02 = $02
!FlameHoppingFlame_03 = $03
!Hammer_04 = $04
!PlayerFireball_05 = $05
!BoneDryBones_06 = $06
!LavaSplash_07 = $07
!TedShooterArm_08 = $08
!UnknownFlickeringObject_09 = $09
!CoinCloudGame_0A = $0A
!PiranhaPlantFireball_0B = $0B
!LotusFiery_0C = $0C
!Baseball_0D = $0D
!WigglerFlower_0E = $0E
!TrailSmoke_0F = $0F
!SpinjumpStars_10 = $10
!YoshiFireball_11 = $11
!WaterBubble_12 = $12

ExtSprYPosLow_1715: skip 10 ;done
ExtSprXPosLow_171F: skip 10 ;done
ExtSprYPosHigh_1729: skip 10 ;done
ExtSprXPosHigh_1733: skip 10 ;done
ExtSprYSpeed_173D: skip 10 ;done
ExtSprXSpeed_1747: skip 10 ;done
ExtSprYPosSpx_1751: skip 10 ;done
ExtSprXPosSpx_175B: skip 10 ;done
ExtSprMisc_1765: skip 10 ;done
ExtSprTimer_176F: skip 10 ;done
ExtSprPriority_1779: skip 10 ;done


ShooterNumber_1783: skip 8 ;done
ShooterYPosLow_178B: skip 8 ;done
ShooterYPosHigh_1793: skip 8 ;done
ShooterXPosLow_179B: skip 8 ;done
ShooterXPosHigh_17A3: skip 8 ;done
ShooterTimer_17AB: skip 8 ;done
ShooterLoadIndex_17B3: skip 8 ;done


LoadingLevelNumber_17BB: skip 1 ;done
Layer1DYPos_17BC: skip 1 ;done
Layer1DXPos_17BD: skip 1 ;done
Layer2DYPos_17BE: skip 1 ;done
Layer2DXPos_17BF: skip 1 ;done

SmokeSprNumber_17C0: skip 4 ;done
; Valid values
!FreeSmoke_00 = $00
!PuffSmoke_01 = $01
!ContactGraphic_02 = $02
!FeetSmoke_03 = $03
!UnusedSmoke_04 = $04
!Glitter_05 = $05

SmokeSprYPos_17C4: skip 4 ;done
SmokeSprXPos_17C8: skip 4 ;done
SmokeSprTimer_17CC: skip 4 ;done


CoinSpriteExists_17D0: skip 4 ;done
CoinSpriteYPosLow_17D4: skip 4 ;done
CoinSpriteYSpeed_17D8: skip 4 ;done
CoinSpriteYPosSpx_17DC: skip 4 ;done
CoinSpriteXPosLow_17E0: skip 4 ;done
CoinSpriteLayer_17E4: skip 4 ;done
CoinSpriteYPosHigh_17E8: skip 4 ;done
CoinsPriteXPosHigh_17EC: skip 4 ;done


MinorSprNumber_17F0: skip 12 ;done
MinorSprYPosLow_17FC: skip 12 ;done
MinorSprXPosLow_1808: skip 12 ;done
MinorSprYPosHigh_1814: skip 12 ;done
MinorSprYSpeed_1820: skip 12 ;done
MinorSprXSpeed_182C: skip 12 ;done
MinorSprYPosSpx_1838: skip 12 ;done
MinorSprXPosSpx_1844: skip 12 ; unreferenced, maybe unused?
MinorSprTimer_1850: skip 12 ;done


PlayerDisableObjInt_185C: skip 1 ;done
MinorSprSlotIdx_185D: skip 1 ;done

; TODO: clarify more this sratch RAM
; Sometimes used to keep track of a tile to generate at $00:BEB0 (before storing to $7E:009C)
; may be used in conjunction with $7E:18B6
TileGenerateTrack_185E:
; used to determine the player Y position when they're on the line guided rope
PlayerYPosLine_185E:
; used to determine positions and such of Yoshi's tiles
YoshiAnimationMirror_185E:
; In the sprite/object interaction routine, it's also used to indicate which layer the sprite is touching. 00 = layer 1; 01 = layer 2
SpriteLayer_185E:
LakituBaitRelY_185E:
GrowingPipeTile_185E:
FlyingBlock_185E:
PlayerOnPlatform_185E:
Parachute_185E:
PokeySlot_185E:
FireballSlot_185E:
ChuckSplitFlag_185E: ; during the split routine, used to determine whether it is the first or second Chuck being generated
BooCloudTimerMirror_185E:
FlameYPosIdx_185E:
skip 1 ;done

SprMap16TouchVertLow_185F: skip 1 ;done
SprMap16TouchHorizLow_1860: skip 1 ;done
SpriteOverwrite_1861: skip 1 ;done
SprMap16TouchHorizHigh_1862: skip 1 ;done
SmokeSprSlotIdx_1863: skip 1 ;done
; 7E1864 unused
skip 1
CoinSprSlotIdx_1865: skip 1 ;done
BrPlatAngleParity_1866: skip 2 ;done
Map16MirrorHittable_1868: skip 1 ;done
; 7E1869 - 7E186A unused
skip 2
MulticoinTimer_186B: skip 1 ;done
SpriteOffscreenVert_186C: skip 12 ;done
NetDoorPlayerXOffset_1878: skip 1 ;done
; 7E1879 unused
skip 1
RidingYoshi_187A: skip 1 ;done
SpriteMisc_187B: skip 12 ;done
ScreenShakeTimer_1887: skip 1 ;done
ScreenShakeYOffset_1888: skip 2 ;done
Unused_188A: skip 1 ;done
PlayerYOffset_188B: skip 1 ;done
BossBGSpriteUpdate_188C: skip 1 ;done
BossBGSpriteXCalc_188D: skip 1 ;done
; 7E188E unused
skip 1
BonusGameComplete_188F: skip 1 ;done
BonusGame1UpCount_1890: skip 1 ;done
PBalloonTimer_1891: skip 1 ;done
ClusterSprNumber_1892: skip 20 ;done

; this value is read, but never written, except during RAM cleaup
; sets Y, but likely unused
Empty_18A6: skip 1 ;done
Map16TileDestroy_18A7: skip 1 ;done
BossPillarFalling_18A8: skip 2 ;done
BossPillarYPos_18AA: skip 2 ;done
YoshiSwallowTimer_18AC: skip 1 ;done
YoshiWalkingTimer_18AD: skip 1 ;done
YoshiStartEatTimer_18AE: skip 1 ;done
YoshiDuckTimer_18AF: skip 1 ;done
YoshiXPos_18B0: skip 2 ;done
YoshiYPos_18B2: skip 2 ;done
; 7E18B4 unused
skip 1
StandingOnCage_18B5: skip 1
TileGenerateTrackB_18B6: skip 1
; 7E18B7 unused
skip 1
RunClusterSprites_18B8: skip 1
CurrentGenerator_18B9: skip 1
BooRingIndex_18BA: skip 1
; 7E18BB unused
skip 1
SkullRaftSpeed_18BC: skip 1
PlayerStunnedTimer_18BD: skip 1
PlayerClimbFlag_18BE: skip 1
SpriteWillAppear_18BF: skip 1
SpriteRespawnTimer_18C0: skip 1
SpriteRespawnNumber_18C1: skip 1
PlayerInCloud_18C2: skip 1
SpriteRespawnYPos_18C3: skip 2
; 7E18C5 - 7E18CC unused
skip 8
BounceSpriteSlotIdx_18CD: skip 1
TurnBlockSpinTimer_18CE: skip 4
StarKillCounter_18D2: skip 1
PlayerSparkleTimer_18D3: skip 1
RedBerriesEaten_18D4: skip 1
PinkBerriesEaten_18D5: skip 1
EatenBerryType_18D6: skip 1
SprMap16TouchVertHigh_18D7: skip 1
; 7E18D8 unused
skip 1
NoYoshiIntroTimer_18D9: skip 1 ;done
YoshiEggSprite_18DA: skip 1 ;done
Unread_18DB: skip 1 ;done
DuckingYoshi_18DC: skip 1 ;done
SilverCoinsCollected_18DD: skip 1
EggLaidTimer_18DE: skip 1
YoshiSlot_18DF: skip 1 ; TODO: should be YoshiPlus1 or something that indicates it is not really the slot
LakituCloudTimer_18E0: skip 1
LakituCloudSlot_18E1: skip 1
YoshiSlotMirror_18E2: skip 1
GameCloudCoinCount_18E3: skip 1
GivePlayerLives_18E4: skip 1
GiveLivesTimer_18E5: skip 1
; 7E18E6 unused
skip 1
YoshiCanStomp_18E7: skip 1 ;done
YoshiGrowingTimer_18E8: skip 1 ;done
SmokeSpriteSlotFull_18E9: skip 1
MinExtSpriteXPosHigh_18EA: skip 12
; 7E18F6 unused
skip 1
ScoreSprIndex_18F7: skip 1
BounceSpriteIntTimer_18F8: skip 4
ExtSpriteSlotIdx_18FC: skip 1
ChuckIsWhistling_18FD: skip 1
DiagonalBulletTimer_18FE: skip 1
ShooterSlotIdx_18FF: skip 1
BonusStarsGained_1900: skip 1
BounceSpriteYXPPCCCT_1901: skip 4
IggyLarryPlatTilt_1905: skip 1
IggyLarryPlatWait_1906: skip 1
IggyLarryPlatPhase_1907: skip 1
; 7E1908 unused
skip 1
BlockSnakeActive_1909: skip 1
BooCloudTimer_190A: skip 1
BooTransparency_190B: skip 1
DirectCoinTimer_190C: skip 1
FinalCutscene_190D: skip 1
SpriteBuoyancy_190E: skip 1
SpriteTweakerF_190F: skip 12
Empty_191B: skip 1
YoshiHasKey_191C: skip 1 ;done
SumoClustOverwrite_191D: skip 1
BigSwitchPressTimer_191E: skip 1
; 7E191F unused
skip 1
BonusOneUpsRemain_1920: skip 1
FinalMessageTimer_1921: skip 2
; 7E1923 - 7E1924 unused
skip 2
LevelModeSetting_1925: skip 1
; 7E1926 - 7E1927 unused
skip 2
LevelLoadObject_1928: skip 1
; 7E1929 unused
skip 1
LevelEntranceType_192A: skip 1
SpriteTileset_192B: skip 1
; 7E192C unused
skip 1
ForegroundPalette_192D: skip 1
SpritePalette_192E: skip 1
BackAreaColor_192F: skip 1
BackgroundPalette_1930: skip 1
ObjectTileset_1931: skip 1
Empty_1932: skip 1
LayerProcessing_1933: skip 2
MarioStartFlag_1935: skip 1
; 7E1936 - 7E1937 unused
skip 2
SpriteLoadStatus_1938: skip 128
ExitTableLow_19B8: skip 32
ExitTableHigh_19D8: skip 32
ItemMemoryTable_19F8: skip 384
HardcodedPathIsUsed_1B78: skip 2
HardcodedPathIndex_1B7A: skip 2
Layer1PosSpx_1B7C: skip 2
OverworldTightPath_1B7E: skip 1
; 7E1B7F unused
skip 1
OverworldClimbing_1B80: skip 2
OverworldEventXPos_1B82: skip 1
OverworldEventYPos_1B83: skip 1
OverworldEventSize_1B84: skip 2
OverworldEventProcess_1B86: skip 1
OverworldPromptProcess_1B87: skip 1
MessageBoxExpand_1B88: skip 1
MessageBoxTimer_1B89: skip 1
OWPromptArrowDir_1B8A: skip 1
OWPromptArrowTimer_1B8B: skip 1
OWTransitionFlag_1B8C: skip 1
OWTransitionXCalc_1B8D: skip 2
OWTransitionYCalc_1B8F: skip 2
BlinkCursorTimer_1B91: skip 1
BlinkCursorPos_1B92: skip 1
UseSecondaryExit_1B93: skip 1
DisableBonusSprite_1B94: skip 1
YoshiHeavenFlag_1B95: skip 1 ;done
SideExitEnabled_1B96: skip 1
Empty_1B97: skip 2
ShowPeaceSign_1B99: skip 1
BGFastScrollActive_1B9A: skip 1
RemoveYoshiFlag_1B9B: skip 1 ;done
EnteringStarWarp_1B9C: skip 1
Layer3TideTimer_1B9D: skip 1
SwapOverworldMusic_1B9E: skip 1
ReznorBridgeCount_1B9F: skip 1
OverworldEarthquake_1BA0: skip 1
LevelLoadObjectTile_1BA1: skip 1
Mode7TileIndex_1BA2: skip 1
Mode7GfxBuffer_1BA3: skip 15
GfxBppConvertBuffer_1BB2: skip 10
GfxBppConvertFlag_1BBC: skip 39
Layer3Setting_1BE3: skip 1
Layer1VramAddr_1BE4: skip 2
Layer1VramBuffer_1BE6: skip 256
Layer2VramAddr_1CE6: skip 2
Layer2VramBuffer_1CE8: skip 256
OWSubmapSwapProcess_1DE8: skip 1
OWLoadEventFlag_1DE9:
CreditsScreenNumber_1DE9: skip 1
OverworldEvent_1DEA: skip 1
EventTileIndex_1DEB: skip 2
EventLength_1DED: skip 2
; 7E1DEF unused
skip 1
OverworldFreeCamXPos_1DF0: skip 2
OverworldFreeCamYPos_1DF2: skip 2
TitleInputIndex_1DF4: skip 1
VariousPromptTimer_1DF5: skip 1
StarWarpIndex_1DF6: skip 1
StarWarpLaunchSpeed_1DF7: skip 1
StarWarpLaunchTimer_1DF8: skip 1
SPCIO0_1DF9: skip 1
SPCIO1_1DFA: skip 1
SPCIO2_1DFB: skip 1
SPCIO3_1DFC: skip 1
Empty_1DFD: skip 2
LastUsedMusic_1DFF: skip 1
; 7E1E00 unused
skip 1
DebugFreeRoam_1E01: skip 1
ClusterSprYPosLow_1E02: skip 20
ClusterSprXPosLow_1E16: skip 20
ClusterSprYPosHigh_1E2A: skip 20
ClusterSprXPosHigh_1E3E: skip 20
ClusterSprMisc_1E52: skip 20
ClusterSprMisc_1E66: skip 20
ClusterSprMisc_1E7A: skip 20
ClusterSprMisc_1E8E: skip 20
OWLevelSettings_1EA2: skip 96
OWEventsActivated_1F02: skip 15
OWPlayerSubmap_1F11: skip 2
OWPlayerAnimation_1F13: skip 4
OWPlayerXPos_1F17: skip 2
OWPlayerYPos_1F19: skip 6
OWPlayerXPosPtr_1F1F: skip 2
OWPlayerYPosPtr_1F21: skip 6
SwitchBlockFlags_1F27: skip 4
; 7E1F2B - 7E1F2D unused
skip 3
ExitsCompleted_1F2E: skip 1
AllDragonCoinsCollected_1F2F: skip 12
; 7E1F3B unused
skip 1
Checkpoint1upCollected_1F3C: skip 12
; 7E1F48 unused
skip 1
SaveDataBuffer_1F49:         skip 96
SaveDataBufferEvents_1FA9:   skip 15
SaveDataBufferSubmap_1FB8:   skip 2
SaveDataBufferAni_1FBA:      skip 4
SaveDataBufferXPos_1FBE:     skip 2
SaveDataBufferYPos_1FC0:     skip 6
SaveDataBufferXPosPtr_1FC6:  skip 2
SaveDataBufferYPosPtr_1FC8:  skip 6
SaveDataBufferSwitches_1FCE: skip 4
; 7E1FD2 - 7E1FD4 unused
skip 3
SaveDataBufferExits_1FD5: skip 1
SpriteMisc_1FD6: skip 12
SpriteDisableTimer_1FE2: skip 12
MoonCollected_1FEE: skip 12
; 7E1FFA unused
skip 1
LightningFlashIndex_1FFB: skip 1
LightningWaitTimer_1FFC: skip 1
LightningTimer_1FFD: skip 1
CreditsUpdateBG_1FFE: skip 1
; 7E1FFF unused
skip 1

NonMirroredWRAM_2000:
MarioGraphics_200: skip 23808
AnimatedTiles_7D00: skip 15360
Layer2TilemapLow_B900:
SwitchAniXPosHigh_B900: skip 40
SwitchAniYPosHigh_B928: skip 40
SwitchAniZPosHigh_B970: skip 40
SwitchAniXPosLow_B978:  skip 40
SwitchAniYPosLow_B9A0:  skip 40
SwitchAniZPosLow_B9C8:  skip 40
SwitchAniXSpeed_B9F0:   skip 40
SwitchAniYSpeed_BA18:   skip 40
SwitchAniZSpeed_BA40:   skip 40
SwitchAniXSpx_BA68:     skip 40
SwitchAniYSpx_BA90:     skip 40 ; unused?
SwitchAniZSpx_BAB8:     skip 40 ; unused?
skip 544
Layer2TilemapHigh_BD00: skip 1024
; 7EC100 - 7EC67F unused
skip 1408
Mode7BossTilemap_C680: skip 96
; 7EC6E0 - 7EC7FF unused
skip 288
Map16TilesLow_C800: skip 2048
OWLayer1Translevel_D000: skip 2048
OWLayer2Directions_D800: skip 3072
OWLayer1VramBuffer_E400: skip 7168

ORG $7F0000

OWEventTilemap_7F0000: skip 3328
; 7F0D00 - 7F3FFF unused
skip 13056
OWLayer2Tilemap_7F: skip 16384
OAM_reset_7F8000: skip 387
; 7F8183 - 7F837A unused
skip 504
DynStripeImgSize_7F837B: skip 2
DynamicStripeImage_7F837D: skip 784
; 7F868D - 7F977A unused
skip 4334
MarioStartGraphics_7F977B: skip 768
WigglerTable_7F9A7B: skip 512
; 7F9C7B - 7FC7FF unused
skip 11141
Map16TilesHigh_7FC800: skip 14336
