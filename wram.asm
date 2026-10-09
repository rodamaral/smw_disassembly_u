; incsrc "hardware_registers.asm"

; Constants:
!Bank_07 = $07
!Bank_0C = $0C
!Bank_7E = $7E
!Bank_7F = $7F

!OpcodeRTL_6B = $6B
!LDA_F0_F0A9 = $F0A9
!STA_00_008D = $008D

ORG $7E0000

; scratch RAM
; TODO: eventually create a label for each purpose
; TODO: Only 8A-8F not done
; TODO: $00XX
skip 16

; Some valid values
!QuakeTypeGroundPound_35 = $35

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
!ButY = %01000000
!ButSelect = %00100000
!ButStart = %00010000
!DpadUp = %00001000
!DpadDown = %00000100
!DpadLeft = %00000010
!DpadRight = %00000001
!DpadSides = %00000011
!ButBYET_F0 = %11110000

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
!ButAX_C0 = %11000000

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
!GreenKoopa_00 = $00
!RedKoopa_01 = $01
!BlueKoopa_02 = $02
!YellowKoopa_03 = $03
!GreenShell_04 = $04
!RedShell_05 = $05
!BlueShell_06 = $06
!YellowShell_07 = $07
!GreenShellFly_08 = $08
!GreenShellBounce_09 = $09
!RedShellFlyV_0A = $0A
!RedShellFlyH_0B = $0B
!YellowShellWings_0C = $0C
!BobOmb_0D = $0D
!Keyhole_0E = $0E
!Goomba_0F = $0F
!Paragoomba_10 = $10
!BuzzyBeetle_11 = $11
!SpinyFalling_14 = $14
!FishH_15 = $15
!FishV_16 = $16
!FishFlying_17 = $17
!Football_1B = $1B
!BulletBill_1C = $1C
!HoppingFlame_1D = $1D
!Lakitu_1E = $1E
!Magikoopa_1F = $1F
!MagikoopaMagic_20 = $20
!Coin_21 = $21
!GreenVNetKoopa_22 = $22
!RedVNetKoopa_23 = $23
!GreenHNetKoopa_24 = $24
!RedHNetKoopa_25 = $25
!Thwomp_26 = $26
!Thwimp_27 = $27
!BigBoo_28 = $28
!KoopaKid_29 = $29
!DownPiranhaPlant_2A = $2A
!SumoLightning_2B = $2B
!YoshiEgg_2C = $2C
!BabyYoshi_2D = $2D
!SpikeTop_2E = $2E
!Springboard_2F = $2F
!BonyBeetle_31 = $31
!DryBonesLedge_32 = $32
!Podoboo_33 = $33
!BossFireball_34 = $34
!Yoshi_35 = $35
!Boo_37 = $37
!EerieStraight_38 = $38
!EerieWave_39 = $39
!UrchinBetweenWalls_3B = $3B
!UrchinFolloWalls_3C = $3C
!PSwitch_3E = $3E
!ParaGoomba_3F = $3F
!ParaBomb_40 = $40
!DolphinLong_41 = $41
!DolphinShort_42 = $42
!DolphinV_43 = $43
!TorpedoTed_44 = $44
!DirCoins_45 = $45
!DigginChuck_46 = $46
!ChuckRock_48 = $48
!GrowingPipe_49 = $49
!PipeLakitu_4B = $4B
!ExplodingBlock_4C = $4C
!MontyMoleGround_4D = $4D
!MontyMoleLedge_4E = $4E
!PiranhaPlantFireballs_50 = $50
!Ninji_51 = $51
!Throwblock_53 = $53
!CheckerboardPlatH_55 = $55
!RockPlatH_56 = $56
!CheckerboardPlatV_57 = $57
!RockPlatH_58 = $58
!TurnBlockBridgeBoth_59 = $59
!TurnBlockBridgeH_5A = $5A
!FloatingBrownPlat_5B = $5B
!FloatingCheckerboardPlat_5C = $5C
!SmallOrangePlat_5D = $5D
!LargeOrangePlat_5E = $5E
!SwingBrownPlat_5F = $5F
!FlatSwitch_60 = $60
!SkullRaft_61 = $61
!BrownLinePlat_62 = $62
!LinePlat_63 = $63
!Rope_64 = $64
!ChainsawUp_65 = $65
!DownChainsaw_66 = $66
!Grinder_67 = $67
!FuzzyLine_68 = $68
!Unused_69 = $69
!CoinGameCloud_6A = $6A
!WallSpringL_6B = $6B
!WallSpringR_6C = $6C
!InvisibleBlock_6D = $6D
!DinoRhino_6E = $6E
!DinoTorch_6F = $6F
!Pokey_70 = $70
!SuperKoopaRed_71 = $71
!SuperKoopaYellow_72 = $72
!SuperKoopaGRound_73 = $73
!Mushroom_74 = $74
!Flower_75 = $75
!Star_76 = $76
!Feather_77 = $77
!1Up_78 = $78
!Vine_79 = $79
!Firework_7A = $7A
!GoalTape_7B = $7B
!Peach_7C = $7C
!PBalloon_7D = $7D
!FlyingRedCoin_7E = $7E
!YoshiWings_7E = $7E
!GoldenMushroom_7F = $7F
!Key_80 = $80
!ChangingItem_81 = $81
!BonusGame_82 = $82
!FlyingBlockL_83 = $83
!FlyingBlockLR_84 = $84
!Unused_85 = $85
!Wiggler_86 = $86
!LakituCloud_87 = $87
!YoshiHouseSmoke_8B = $8B
!GhostHouseExit_8D = $8D
!CharginChuck_91 = $91
!SplittinChuck_92 = $92
!BouncinChuck_93 = $93
!WhistlinChuck_94 = $94
!ClappinChuck_95 = $95
!UnusedChuck_96 = $96
!PuntinChuck_97 = $97
!PitchinChuck_98 = $98
!VolcanoLotus_99 = $99
!HammerBrother_9B = $9B
!HammerBrotherBlocks_9C = $9C
!Bubble_9D = $9D
!BallChain_9E = $9E
!BanzaiBill_9F = $9F
!Bowser_A0 = $A0
!BowserBall_A1 = $A1
!MechaKoopa_A2 = $A2
!RotatingGrayPlat_A3 = $A3
!SpikeBall_A4 = $A4
!WallSparkyFuzzy_A5 = $A5
!HotHead_A6 = $A6
!IggyBall_A7 = $A7
!Blargg_A8 = $A8
!Reznor_A9 = $A9
!Fishbone_AA = $AA
!Rex_AB = $AB
!WoodenSpikeDown_AC = $AC
!WoodenSpikeUp_AD = $AD
!FishinBoo_AE = $AE
!BooBlock_AF = $AF
!BooStream_B0 = $B0
!CreateEatBlock_B1 = $B1
!FallingSpike_B2 = $B2
!StatueFireball_B3 = $B3
!ReflectingFireball_B6 = $B6
!CarrotTopRight_B7 = $B7
!CarrotTopLeft_B8 = $B8
!InfoBox_B9 = $B9
!TimedLift_BA = $BA
!CastleBlock_BB = $BB
!SlidingKoopa_BD = $BD
!BowserStatue_BC = $BC
!Swooper_BE = $BE
!MegaMole_BF = $BF
!GrayLavaPlat_C0 = $C0
!FlyingBlocks_C1 = $C1
!Blurp_C2 = $C2
!PorcuPuffer_C3 = $C3
!GrayPlatFalls_C4 = $C4
!BigBooBoss_C5 = $C5
!Spotlight_C6 = $C6
!InvisibleMushroom_C7 = $C7
!LightSwitch_C8 = $C8
!BulletBillShooter_C9 = $C9
!EerieGenerator_CB = $CB
!GreenShell_DA = $DA
!5Eeries_DE = $DE
!3GrayPlats_E0 = $E0
!BooCeiling_E1 = $E1
!Unused_E7 = $E7

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
IRQNMICommand_0D9B: skip 1 ;done
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

ThroughMain_0D9D: skip 1 ;done
ThroughSub_0D9E: skip 1 ;done
HDMAEnable_0D9F: skip 1 ;done
ControllersPresent_0DA0: skip 1 ;done
; 7E0DA1 unused
skip 1
byetudlrP1Hold_0DA2: skip 1 ;done
byetudlrP2Hold_0DA3: skip 1 ;done
axlr0000P1Hold_0DA4: skip 1; done
axlr0000P2Hold_0DA5: skip 1 ;done
byetudlrP1Frame_0DA6: skip 1 ;done
byetudlrP2Frame_0DA7: skip 1 ;done
axlr0000P1Frame_0DA8: skip 1 ;done
axlr0000P2Frame_0DA9: skip 1 ;done
byetudlrP1Mask_0DAA: skip 1 ;done
byetudlrP2Mask_0DAB: skip 1 ;done
axlr0000P1Mask_0DAC: skip 1 ;done
axlr0000P2Mask_0DAD: skip 1 ;done
Brightness_0DAE: skip 1 ;done
MosaicDirection_0DAF: skip 1 ;done
MosaicSize_0DB0: skip 1 ;done
KeepModeActive_0DB1: skip 1 ;done
IsTwoPlayerGame_0DB2: skip 1 ;done
CurrentPlayer_0DB3: skip 1 ;done
SavedPlayerLives_0DB4: skip 2 ;done
SavedPlayerCoins_0DB6: skip 2 ;done
SavedPlayerPowerup_0DB7: skip 2
SavedPlayerYoshi_0DBA: skip 2 ;done
SavedPlayerItembox_0DBC: skip 2
PlayerLives_0DBE: skip 1 ;done
PlayerCoins_0DBF: skip 1 ;done
GreenStarBlockCoins_0DC0: skip 1 ;done
CarryYoshiLevels_0DC1: skip 1 ;done
PlayerItembox_0DC2: skip 1 ;done
; 7E0DC3 - 7E0DC6 unused
skip 4
OverworldDestXPos_0DC7: skip 2 ;done
OverworldDestYPos_0DC9: skip 6 ;done
OWPlayerSpeed_0DCF: skip 4 ; done
OWPlayerDirection_0DD3: skip 2 ;done

LevelExitMode_0DD5: skip 1 ;done
; Valid values
!ExitNothing_00 = $00
!ExitNormal_01 = $01
!ExitSecret1_02 = $02
!ExitSecret2_03 = $03
!ExitSecret3_04 = $04
!Exit_05 = $05
!Exit_06 = $06
!ExitDeath_80 = $80
!ExitShowSave_E0 = $E0

PlayerTurnOW_0DD6: skip 2 ;done
PlayerSwitching_0DD8: skip 1 ;done
; 7E0DD9 unused
skip 1
MusicBackup_0DDA: skip 1 ;done
; 7E0DDB - 7E0DDD unused
skip 3
SaveFileDelete_0DDE: skip 1 ;done
OWCloudOAMIndex_0DDF: skip 1 ;done
OWCloudYSpeed_0DE0: skip 5 ;done
OWSpriteNumber_0DE5: skip 16 ;done
OWSpriteMisc_0DF5: skip 16 ;done
OWSpriteMisc_0E05: skip 16 ;done
OWSpriteMisc_0E15: skip 16 ;done
OWSpriteMisc_0E25: skip 16 ;done
OWSpriteXPosLow_0E35: skip 16 ;done
OWSpriteYPosLow_0E45: skip 16 ;done
OWSpriteZPosLow_0E55: skip 16 ;done
OWSpriteXPosHigh_0E65: skip 16 ;done
OWSpriteYPosHigh_0E75: skip 16 ;done
OWSpriteZPosHigh_0E85: skip 16 ; done , unused?
OWSpriteXSpeed_0E95: skip 16 ;done
OWSpriteYSpeed_0EA5: skip 16 ;done
OWSpriteZSpeed_0EB5: skip 16 ;done
OWSpriteXPosSpx_0EC5: skip 16 ;done
OWSpriteYPosSpx_0ED5: skip 16 ;done
OWSpriteZPosSpx_0EE5: skip 16 ;done
KoopaKidActive_0EF5: skip 1 ;done
KoopaKidTile_0EF6: skip 1 ;done
EnterLevelAuto_0EF7: skip 1 ;done
YoshiSavedFlag_0EF8: skip 1 ;done
StatusBar_0EF9: skip 55 ;done
InGameTimerFrames_0F30: skip 1 ;done
InGameTimerHundreds_0F31: skip 1 ;done
InGameTimerTens_0F32: skip 1 ;done
InGameTimerOnes_0F33: skip 1 ;done
PlayerScore_0F34: skip 6 ;done
; 7E0F3A - 7E0F3F unused
skip 6
ScoreIncrement_0F40: skip 2
; 7E0F42 - 7E0F47 unused
skip 6
PlayerBonusStars_0F48: skip 2 ;done
ClusterSprMisc_0F4A: skip 20 ;done
; ClusterSprMisc_0F5E: unused
skip 20
ClusterSprMisc_0F72: skip 20 ;done
ClusterSprMisc_0F86: skip 20 ;done
ClusterSprMisc_0F9A: skip 20 ;done
BooRingAngleLow_0FAE: skip 2
BooRingAngleHigh_0FB0: skip 2
BooRingXPosLow_0FB2: skip 2
BooRingXPosHigh_0FB4: skip 2
BooRingYPosLow_0FB6: skip 2
BooRingYPosHigh_0FB8: skip 2
BooRingOffscreen_0FBA: skip 2
BooRingLoadIndex_0FBC: skip 2
Map16Pointers_0FBE: skip 1024 ;done
ItemMemorySetting_13BE: skip 1 ;done
Translevel_13BF: skip 2 ;done
OverworldLayer1Tile_13C1: skip 2 ;done
CurrentSubmap_13C3: skip 2 ;done
MoonCounter_13C5: skip 1 ;UNUSED ;done
CutsceneID_13C6: skip 1 ;done
YoshiColor_13C7: skip 1 ;done
; 7E13C8 unused
skip 1
ShowContinueEnd_13C9: skip 1 ;done
ShowSavePrompt_13CA: skip 1 ;done
UnusedStarCounter_13CB: skip 1 ;done
CoinAdder_13CC: skip 1 ;done
DisableMidway_13CD: skip 1 ;done
MidwayFlag_13CE: skip 1 ;done
SkipMidwayCastleIntro_13CF: skip 1 ;done
StructureCrushTile_13D0: skip 1 ;done
StructureCrushIndex_13D1: skip 1 ;done
SwitchPalaceColor_13D2: skip 1 ;done
RamLevelReset_13D3:
PauseTimer_13D3: skip 1 ;done
PauseFlag_13D4: skip 1 ;done
Layer3ScrollType_13D5: skip 1 ;done
DrumrollTimer_13D6: skip 1 ;done
IntroMarchYPosSpx_13D7: skip 2 ;done


EndMarchPhase_13D9:
OWProcess_13D9: skip 1 ;done
!MarchCourseClear_00 = $00 ; Show up the course clear text.
!MarchStore_01 = $01 ; Store bonus star text (if applicable), bonus stars not decrementing yet.
!MarchCount_02 = $02 ; Count down timer/convert to score, add up bonus stars to total.
!MarchNOP_03 = $03 ; Do nothing.
;;;
!OwNOP_00 = $00 ; Nothing.
!OwActivate_01 = $01 ; Activate overworld events.
!OwPostEvent_02 = $02 ; Runs as soon as a level is beaten and the events have run.
!OwStanding_03 = $03 ; Standing still on a level tile.
!OwWalking_04 = $04 ; Player is moving in a certain direction.
!OwBeforeTile_05 = $05 ; Runs before settling on a level tile.
!OwFadeOut_06 = $06 ; Fading out to #$07.
!OwSwitchPlayer_07 = $07 ; Switching between Mario and Luigi.
!OwFadeIn_08 = $08 ; Fading in from #$07.
!OwPostFadeIn_09 = $09 ; Follows up #$08, sets $7E:13D9 to #$03.
!OwSubmap_0A = $0A ; Switching between two submaps (not via warp pipe/star).
!OwStarWarp_0B = $0B ; Activate star warp.
!OwStart_0C = $0C ; Player intro march (entering overworld for the first time).

PlayerXPosSpx_13DA: skip 1 ;done
PlayerWalkingPose_13DB: skip 1 ;done
PlayerYPosSpx_13DC: skip 1 ; unused
PlayerTurningPose_13DD: skip 1 ;done
PlayerOverworldPose_13DE: skip 1 ;done
PlayerCapePose_13DF: skip 1 ;done
PlayerPose_13E0: skip 1 ;done
SlopeType_13E1: skip 1 ;done
SpinjumpFireball_13E2: skip 1 ;done
WallRunFlag_13E3: skip 1 ;done
PlayerPMeter_13E4: skip 1 ;done
PlayerPoseLenTimer_13E5: skip 1 ;done
; 7E13E6 - 7E13E7 unused
skip 2
CapeInteracts_13E8: skip 1 ;done
CapeInteractionXPos_13E9: skip 2 ;done
CapeInteractionYPos_13EB: skip 2 ;done
PlayerSlopePose_13ED: skip 1 ;done
CurrentSlope_13EE: skip 1 ;done
PlayerGroundType_13EF: skip 1 ;done
NetDoorDirIndex_13F0: skip 1 ;done
VerticalScrollEnabled_13F1: skip 1 ;done
; 7E13F2 unused
skip 1
PBalloonFlag_13F3: skip 1 ;done
BonusRoomBlocks_13F4: skip 5 ;done
PlayerBehindNet_13F9: skip 1 ;done
PlayerCanJumpWater_13FA: skip 1 ;done
PlayerIsFrozen_13FB: skip 1 ;done
ActiveBoss_13FC: skip 1 ;done
CameraIsScrolling_13FD: skip 1 ;done
CameraScrollDir_13FE: skip 1 ;done
CameraScrollPlayerDir_13FF: skip 1 ;done
CameraProperMove_1400: skip 1 ;done
CameraScrollTimer_1401: skip 1 ;done
NoteBlockActive_1402: skip 1 ;done

; === $7E1403 ===
; 1 byte
; which layer 3 tide setting is enabled
Layer3TideSetting_1403: skip 1 ;done
; Valid values
!Tide_UpAndDown = 1
!Tide_Stationary = 2

ScreenScrollAtWill_1404: skip 1 ;done
DrawYoshiInPipe_1405: skip 1 ;done
BouncingFlag_1406: skip 1 ;done
FlightPhase_1407: skip 1 ;done
NextFlightPhase_1408: skip 1 ;done
MaxStageOfFlight_1409: skip 1
Unused_140A: skip 1 ;done
; 7E140B - 7E140C unused
skip 2
SpinJumpFlag_140D: skip 1 ;done
Layer2Touched_140E: skip 1 ;done
ReznorOAMIndex_140F: skip 1 ;done
YoshiHasWingsGfx_1410: skip 1 ;done
HorizLayer1Setting_1411: skip 1 ;done
VertLayer1Setting_1412: skip 1 ;done
HorizLayer2Setting_1413: skip 1 ;done
VertLayer2Setting_1414: skip 1 ;done
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
DragonCoinsCollected_1420: skip 1 ;done
OneUpCheckpoints_1421: skip 1 ;done
DragonCoinsShown_1422: skip 1 ;done
SwitchPalacePressed_1423: skip 1 ;done
DisplayBonusStars_1424: skip 1 ;done
BonusGameFlag_1425: skip 1 ;done

MessageBoxTrigger_1426: skip 1 ;done
; Valid values
!MessageNone_00 = $00
!Message_01 = $01
!Message_02 = $02
!MessageYoshi_03 = $03

ClownCarImage_1427: skip 1 ;done
ClownCarPropeller_1428: skip 1 ;done
BowserPalette_1429: skip 1 ;done
CameraMoveTrigger_142A: skip 2 ;done
CameraLeftBuffer_142C: skip 2 ;done
CameraRightBuffer_142E: skip 2 ;done
SolidTileStart_1430: skip 1 ;done
SolidTileEnd_1431: skip 1 ;done
DirectCoinInit_1432: skip 1 ;done
SpotlightSize_1433: skip 1 ;done
KeyholeTimer_1434: skip 1 ;done
KeyholeDirection_1435: skip 1 ;done
KeyholeXPos_1436: skip 2 ;done
KeyholeYPos_1438: skip 2 ;done
UploadMarioStart_143A: skip 1 ;done
DeathMessage_143B: skip 1 ;done
GameOverAnimation_143C: skip 1 ;done
GameOverTimer_143D: skip 1 ;done
Layer1ScrollCmd_143E: skip 1 ;done
Layer2ScrollCmd_143F: skip 1 ;done
Layer1ScrollBits_1440: skip 1 ;done
Layer2ScrollBits_1441: skip 1 ;done
Layer1ScrollType_1442: skip 1 ;done
CutsceneTextTimer_1443:  ;done
Layer2ScrollType_1443: skip 1  ;done
Layer1ScrollTimer_1444: skip 1 ;done
Layer2ScrollTimer_1445: skip 1 ;done
Layer1ScrollXSpeed_1446: skip 2 ;done
Layer1ScrollYSpeed_1448: skip 2 ;done
Layer2ScrollXSpeed_144A: skip 2 ;done
Layer2ScrollYSpeed_144C: skip 2 ;done
Layer1ScrollXPosUpd_144E: skip 2 ;done
Layer1ScrollYPosUpd_1450: skip 2 ;done
Layer2ScrollXPosUpd_1452: skip 2 ;done
Layer2ScrollYPosUpd_1454: skip 2 ;done
ScrollLayerIndex_1456: skip 1 ;done
CreditsJumpingYoshi_1457: skip 1 ;done
Layer3ScrollXSpeed_1458: skip 2 ;done
Layer3ScrollYSpeed_145A: skip 2 ;done
Layer3ScrollXPosUpd_145C: skip 2 ;done
; 7E145E - 7E145F unused
skip 2
Layer3ScroolDir_1460: skip 1 ;done
; 7E1461 unused
skip 1
NextLayer1XPos_1462: skip 2 ;done
NextLayer1YPos_1464: skip 2 ;done
NextLayer2XPos_1466: skip 2 ;done
NextLayer2YPos_1468: skip 2 ;done
Layer3HorizOffset_146A: skip 2 ;done
; 7E146C - 7E146F unused
skip 4
CarryingFlag_1470: skip 1 ;done
OnSolidSprite_1471: skip 1 ;done
LightTopWinOpenPos_1472: skip 1 ;done
; 7E1473 unused
skip 1
LightTopWinClosePos_1474: skip 1 ;done
; 7E1475 unused
skip 1
LightBotWinOpenPos_1476: skip 1 ;done
; 7E1477 unused
skip 1
LightBotWinClosePos_1478: skip 1 ;done
; 7E1479 unused
skip 1
LightWinOpenCalc_147A: skip 1 ;done
; 7E147B unused
skip 1
LightWinCloseCalc_147C: skip 1 ;done
; 7E147D unused
skip 1
LightWinOpenMove_147E: skip 1 ;done
LightWinCloseMove_147F: skip 1 ;done
LightLeftWidth_1480: skip 1 ;done
LightRightWidth_1481: skip 1 ;done
LightSkipInit_1482: skip 1 ;done
LightMoveDir_1483: skip 1 ;done
LightLeftRelPos_1484: skip 1 ;done
LightRightRelPos_1485: skip 1 ;done
LightExists_1486: skip 1 ;done
; 7E1487 - 7E148A unused
skip 4
RNGCalc_148B: skip 2 ;done
RandomNumber_148D: skip 2 ;done
CarryingFlagMirror_148F: skip 1 ;done
StarTimer_1490: skip 1 ;done
SpriteXMovement_1491: skip 1 ;done
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

BowserWaitTimer_14B0: ;done
LakituCloudTempXPos_14B0: ;done
RotationCenterX_14B0: skip 1 ;done

BowserWaitTimer_14B1: skip 1 ;done

LakituCloudTempYPos_14B2: ;done
RotationCenterY_14B2: ;done
BowserFlyawayCounter_14B2: skip 1 ;done

ClownCarTeardropPos_14B3: skip 1 ;done

IggyLarryPlatIntXPos_14B4: ;done
BrSwingXDist_14B4: ;done
BowserMusicIndex_14B4: skip 1 ;done

BowserHurtState_14B5: skip 1 ;done

IggyLarryPlatIntYPos_14B6: ;done
BrSwingYDist_14B6: ;done
BowserSteelieTimer_14B6: skip 1 ;done

BowserFireXPos_14B7: skip 1 ;done

IggyLarryTempXPos_14B8: ;done
RotationXPos_14B8: ;done
BowserAttackType_14B8: skip 2 ;done

IggyLarryTempYPos_14BA: ;done
RotationYPos_14BA: ;done
BrSwingPlatYPos_14BA: skip 2 ;done

RotationRadiusX_14BC: skip 2 ;done
; 7E14BE unused
skip 1

RotationRadiusY_14BF: skip 2 ;done
; 7E14C1 unused
skip 1

RotationSine_14C2: skip 2 ;done
; 7E14C4 unused
skip 1

RotationCosine_14C5: skip 2 ;done
; 7E14C7 unused
skip 1


SpriteStatus_14C8: skip 12 ;done
; Valid values
!StatusEmpty_00 = $00
!StatusInit_01 = $01
!StatusFall_02 = $02
!StatusSmush_03 = $03
!StatusSpinkill_04 = $04
!StatusLava_05 = $05
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
!NoRespawn_FF = $FF

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
; Valid values:
!MinorEmpty_00 = $00
!MinorBrick_01 = $01
!MinorStar_02 = $02
!MinorEggFragment_03 = $03
!MinorPodobooFlame_04 = $04
!MinorSparkle_05 = $05
!MinorFishZ_06 = $06
!MinorWaterSplash_07 = $07
!MinorRightNote_08 = $08
!MinorLeftNote_09 = $09
!MinorBooStream_0A = $0A
!MinorYoshiSmoke_0B = $0B

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
StandingOnCage_18B5: skip 1 ;done
TileGenerateTrackB_18B6: skip 1 ;done
; 7E18B7 unused
skip 1
RunClusterSprites_18B8: skip 1 ;done
CurrentGenerator_18B9: skip 1 ;done
BooRingIndex_18BA: skip 1 ;done
; 7E18BB unused
skip 1
SkullRaftSpeed_18BC: skip 1 ;done
PlayerStunnedTimer_18BD: skip 1 ;done
PlayerClimbFlag_18BE: skip 1 ;done
SpriteWillAppear_18BF: skip 1 ;done
SpriteRespawnTimer_18C0: skip 1 ;done
SpriteRespawnNumber_18C1: skip 1 ;done
PlayerInCloud_18C2: skip 1 ;done
SpriteRespawnYPos_18C3: skip 2 ;done
; 7E18C5 - 7E18CC unused
skip 8
BounceSpriteSlotIdx_18CD: skip 1 ;done
TurnBlockSpinTimer_18CE: skip 4 ;done
StarKillCounter_18D2: skip 1 ;done
PlayerSparkleTimer_18D3: skip 1 ;done
RedBerriesEaten_18D4: skip 1 ;done
PinkBerriesEaten_18D5: skip 1 ;done
EatenBerryType_18D6: skip 1 ;done
SprMap16TouchVertHigh_18D7: skip 1 ;done
; 7E18D8 unused
skip 1
NoYoshiIntroTimer_18D9: skip 1 ;done
YoshiEggSprite_18DA: skip 1 ;done
Unread_18DB: skip 1 ;done
DuckingYoshi_18DC: skip 1 ;done
SilverCoinsCollected_18DD: skip 1 ;done
EggLaidTimer_18DE: skip 1 ;done
YoshiSlot_18DF: skip 1 ; TODO: should be YoshiPlus1 or something that indicates it is not really the slot
LakituCloudTimer_18E0: skip 1 ;done
LakituCloudSlot_18E1: skip 1 ;done
YoshiSlotMirror_18E2: skip 1 ;done
GameCloudCoinCount_18E3: skip 1 ;done
GivePlayerLives_18E4: skip 1 ;done
GiveLivesTimer_18E5: skip 1 ;done
; 7E18E6 unused
skip 1 ;done
YoshiCanStomp_18E7: skip 1 ;done
YoshiGrowingTimer_18E8: skip 1 ;done
SmokeSpriteSlotFull_18E9: skip 1 ;done
MinExtSpriteXPosHigh_18EA: skip 12 ;done
; 7E18F6 unused
skip 1
ScoreSprIndex_18F7: skip 1 ;done
BounceSprIntTimer_18F8: skip 4 ;done
ExtSpriteSlotIdx_18FC: skip 1 ;done
ChuckIsWhistling_18FD: skip 1 ;done
DiagonalBulletTimer_18FE: skip 1 ;done
ShooterSlotIdx_18FF: skip 1 ;done
BonusStarsGained_1900: skip 1 ;done
BounceSprYXPPCCCT_1901: skip 4 ;done
IggyLarryPlatTilt_1905: skip 1 ;done
IggyLarryPlatWait_1906: skip 1 ;done
IggyLarryPlatPhase_1907: skip 1 ;done
; 7E1908 unused
skip 1 ;done
BlockSnakeActive_1909: skip 1 ;done
BooCloudTimer_190A: skip 1 ;done
BooTransparency_190B: skip 1 ;done
DirectCoinTimer_190C: skip 1 ;done
FinalCutscene_190D: skip 1 ;done
SpriteBuoyancy_190E: skip 1 ;done
wcdj5sDp_190F: skip 12 ;done
Empty_191B: skip 1 ;done
YoshiHasKey_191C: skip 1 ;done
SumoClustOverwrite_191D: skip 1 ;done
BigSwitchPressTimer_191E: skip 1 ;done
; 7E191F unused
skip 1 ;done
BonusOneUpsRemain_1920: skip 1 ;done
FinalMessageTimer_1921: skip 2 ;done
; 7E1923 - 7E1924 unused
skip 2 ;done
LevelModeSetting_1925: skip 1 ;done
; 7E1926 - 7E1927 unused
skip 2 ;done
LevelLoadObject_1928: skip 1 ;done
; 7E1929 unused
skip 1 ;done
LevelEntranceType_192A: skip 1 ;done
SpriteTileset_192B: skip 1 ;done
; 7E192C unused
skip 1 ;done
ForegroundPalette_192D: skip 1 ;done
SpritePalette_192E: skip 1 ;done
BackAreaColor_192F: skip 1 ;done
BackgroundPalette_1930: skip 1 ;done
ObjectTileset_1931: skip 1 ;done
Empty_1932: skip 1 ;done
LayerProcessing_1933: skip 2 ;done
MarioStartFlag_1935: skip 1 ;done
; 7E1936 - 7E1937 unused
skip 2

SpriteLoadStatus_1938: skip 128 ;done
!Respawn_00 = 0

ExitTableLow_19B8: skip 32 ;done
ExitTableHigh_19D8: skip 32 ;done
ItemMemoryTable_19F8: skip 384 ;done
HardcodedPathIsUsed_1B78: skip 2 ;done
HardcodedPathIndex_1B7A: skip 2 ;done
Layer1PosSpx_1B7C: skip 2 ;done
OverworldTightPath_1B7E: skip 1 ;done
; 7E1B7F unused
skip 1 ;done
OWClimbing_1B80: skip 2 ;done
OWEventXPos_1B82: skip 1 ;done
OWEventYPos_1B83: skip 1 ;done
OWEventSize_1B84: skip 2 ;done
OWEventProcess_1B86: skip 1 ;done
OWPromptProcess_1B87: skip 1 ; done
MessageBoxExpand_1B88: skip 1 ;done
MessageBoxTimer_1B89: skip 1 ;done
OWPromptArrowDir_1B8A: skip 1 ;done
OWPromptArrowTimer_1B8B: skip 1 ;done
OWTransitionFlag_1B8C: skip 1 ;done
OWTransitionXCalc_1B8D: skip 2 ;done
OWTransitionYCalc_1B8F: skip 2 ;done
BlinkCursorTimer_1B91: skip 1 ;done
BlinkCursorPos_1B92: skip 1 ;done
UseSecondaryExit_1B93: skip 1 ;done
DisableBonusSprite_1B94: skip 1 ;done
YoshiHeavenFlag_1B95: skip 1 ;done
SideExitEnabled_1B96: skip 1 ;done
Empty_1B97: skip 2
ShowPeaceSign_1B99: skip 1 ;done
BGFastScrollActive_1B9A: skip 1 ;done
RemoveYoshiFlag_1B9B: skip 1 ;done
EnteringStarWarp_1B9C: skip 1 ;done
Layer3TideTimer_1B9D: skip 1 ;done
SwapOverworldMusic_1B9E: skip 1 ;done
ReznorBridgeCount_1B9F: skip 1 ;done
OWEarthquake_1BA0: skip 1;done
LevelLoadObjectTile_1BA1: skip 1;done
Mode7TileIndex_1BA2: skip 1 ;done
Mode7GfxBuffer_1BA3: skip 15 ;done
GfxBppConvertBuffer_1BB2: skip 10 ;done
GfxBppConvertFlag_1BBC: skip 39 ;done
Layer3Setting_1BE3: skip 1;done
Layer1VramAddr_1BE4: skip 2;done
Layer1VramBuffer_1BE6: skip 256 ;done
Layer2VramAddr_1CE6: skip 2 ;done
Layer2VramBuffer_1CE8: skip 256 ;done
OWSubmapSwapProcess_1DE8: skip 1 ;done
OWLoadEventFlag_1DE9: ;done
CreditsScreenNumber_1DE9: skip 1 ;done
OverworldEvent_1DEA: skip 1 ;done
EventTileIndex_1DEB: skip 2 ;done
EventLength_1DED: skip 2 ;done
; 7E1DEF unused
skip 1 ;done
OWFreeCamXPos_1DF0: skip 2 ;done
OWFreeCamYPos_1DF2: skip 2 ;done
TitleInputIndex_1DF4: skip 1 ;done

; Timer used for multiple purposes:
; How long a particular input during the intro sequence will remain pressed.
; How long the Nintendo Presents screen will remain active.
; How long a Switch Palace message will remain active.
; How long the player has to wait before they can dismiss the intro message.
NintendoPresentsTimer_1DF5: ;done
IntroSequenceTimer_1DF5: ;done
SwitchPalaceTimer_1DF5: skip 1 ;done

StarWarpIndex_1DF6: skip 1 ;done
StarWarpLaunchSpeed_1DF7: skip 1 ;done
StarWarpLaunchTimer_1DF8: skip 1 ;done
SPCIO0_1DF9: skip 1 ;done
SPCIO1_1DFA: skip 1 ;done
SPCIO2_1DFB: skip 1 ;done
SPCIO3_1DFC: skip 1 ;done
; Empty_1DFD: skip 2
; $1DFD is set, but unused
skip 2 ;done
LastUsedMusic_1DFF: skip 1 ;done
; 7E1E00 unused
skip 1 ;done
DebugFreeRoam_1E01: skip 1; done
ClusterSprYPosLow_1E02: skip 20 ;done
ClusterSprXPosLow_1E16: skip 20 ;done
ClusterSprYPosHigh_1E2A: skip 20 ;done
ClusterSprXPosHigh_1E3E: skip 20 ;done
ClusterSprMisc_1E52: skip 20 ;done
ClusterSprMisc_1E66: skip 20 ;done
ClusterSprMisc_1E7A: skip 20 ;done
ClusterSprMisc_1E8E: skip 20 ;done
OWLevelSettings_1EA2: skip 96 ;done
OWEventsActivated_1F02: skip 15 ;done
OWPlayerSubmap_1F11: skip 2 ;done
OWPlayerAnimation_1F13: skip 4 ;done
OWPlayerXPos_1F17: skip 2 ;done
OWPlayerYPos_1F19: skip 6 ;done
OWPlayerXPosPtr_1F1F: skip 2 ;done
OWPlayerYPosPtr_1F21: skip 6 ;done
SwitchBlockFlags_1F27: skip 4 ;done
; 7E1F2B - 7E1F2D unused
skip 3 ;done
ExitsCompleted_1F2E: skip 1 ;done
AllDragonCoinsCollected_1F2F: skip 12 ;done
; 7E1F3B unused
skip 1 ;done
Checkpoint1upCollected_1F3C: skip 12 ;done
; 7E1F48 unused
skip 1 ;done
SaveDataBuffer_1F49:         skip 96 ;done
SaveDataBufferEvents_1FA9:   skip 15 ;done
SaveDataBufferSubmap_1FB8:   skip 2 ;done
SaveDataBufferAni_1FBA:      skip 4 ;done
SaveDataBufferXPos_1FBE:     skip 2 ;done
SaveDataBufferYPos_1FC0:     skip 6 ;done
SaveDataBufferXPosPtr_1FC6:  skip 2 ;done
SaveDataBufferYPosPtr_1FC8:  skip 6 ;done
SaveDataBufferSwitches_1FCE: skip 4 ;done
; 7E1FD2 - 7E1FD4 unused
skip 3 ;done
; SaveDataBufferExits_1FD5:
skip 1 ;done ;unused
SpriteUnused_1FD6: skip 12 ;done
SpriteDisableTimer_1FE2: skip 12 ;done
MoonCollected_1FEE: skip 12 ;done
; 7E1FFA unused
skip 1
LightningFlashIndex_1FFB: skip 1 ;done
LightningWaitTimer_1FFC: skip 1 ;done
LightningTimer_1FFD: skip 1 ;done
CreditsUpdateBG_1FFE: skip 1 ;done
; 7E1FFF unused
skip 1 ;done

NonMirroredWRAM_2000:
MarioGraphics_2000: skip 23808 ;done
AnimatedTiles_7D00: skip 15360 ;unreferenced
Layer2TilemapLow_B900: ;; TODO
SwitchAniXPosHigh_B900: skip 40 ;done
SwitchAniYPosHigh_B928: skip 40 ;done
SwitchAniZPosHigh_B970: skip 40 ;done
SwitchAniXPosLow_B978:  skip 40 ;done
SwitchAniYPosLow_B9A0:  skip 40 ;done
SwitchAniZPosLow_B9C8:  skip 40 ;done
SwitchAniXSpeed_B9F0:   skip 40 ;done
SwitchAniYSpeed_BA18:   skip 40 ;done
SwitchAniZSpeed_BA40:   skip 40 ;done
SwitchAniXSpx_BA68:     skip 40 ;done
SwitchAniYSpx_BA90:     skip 40 ; unused?
SwitchAniZSpx_BAB8:     skip 40 ; unused?
skip 544
Layer2TilemapHigh_BD00: skip 1024 ;done
; 7EC100 - 7EC67F unused
skip 1408
Mode7BossTilemap_C680: skip 96 ;done
; 7EC6E0 - 7EC7FF unused
skip 288
Map16TilesLow_C800: skip 2048 ;done
OWLayer1Translevel_D000: skip 2048 ;done
OWLayer2Directions_D800: skip 3072 ;done
OWLayer1VramBuffer_E400: skip 7168 ;done

ORG $7F0000

OWEventTilemap_7F0000: skip 3328 ;done
; 7F0D00 - 7F3FFF unused
skip 13056
OWLayer2Tilemap_7F4000: skip 16384 ;done
OAM_reset_7F8000: skip 387 ;done
; 7F8183 - 7F837A unused
skip 504
DynStripeImgSize_7F837B: skip 2 ;done
DynamicStripeImage_7F837D: skip 784 ;done, except offsets
; 7F868D - 7F977A unused
skip 4334
MarioStartGraphics_7F977B: skip 768 ;done
WigglerTable_7F9A7B: skip 512 ; unreferenced
; 7F9C7B - 7FC7FF unused
skip 11141
Map16TilesHigh_7FC800: skip 14336 ;done
