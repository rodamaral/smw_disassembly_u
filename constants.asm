; Bank references
!Bank_00 = $00
!Bank_07 = $07
!Bank_0C = $0C
!Bank_0D = $0D
!Bank_7E = $7E
!Bank_007E = $007E
!Bank_7F = $7F
!Bank_007F = $007F

; Address references
!AddrMainPalette_0703 = $0703
!AddrCopyPalette_0905 = $0905
!Addr_8000 = $8000
!Addr_9100 = $9100
!Addr_9A7B = $9A7B
!Addr_9A7B_Low = !Addr_9A7B&$FF
!Addr_9A7B_High = !Addr_9A7B>>8
!Addr_B900 = $B900
!Addr_BD00 = $BD00
!Addr_C800 = $C800
!Addr_F7DF = $F7DF

; Opcode references
!OpcodeRTL_6B = $6B
!LDA_F0_F0A9 = $F0A9
!STA_00_008D = $008D

; =============================================================================
; Entity Constants
; =============================================================================

; Quake Types

!QuakeTypeGroundPound_35 = $35


; =============================================================================
; Block Constants
; =============================================================================

; -----------------------------------------------------------------------------
; Block Events
; -----------------------------------------------------------------------------

!BlockEvtItemFromTurn_00 = !TurnBlockStatic_01-1
!BlockEvtHitNote_01 = !NoteBlock_02-1
!BlockEvtHitQuestion_02 = !QuestionBlock_03-1
!BlockEvtBounceSideways_03 = !SidewaysBlock_04-1
!BlockEvtTranslucentBlock_04 = !TranslucentBlock_05-1
!BlockEvtOnOffBlock_05 = !OnBlock_06-1
!BlockEvtSpinTurn_06 = !TurnBlockTurning_07-1
!BlockEvtBreakTurn_07 = $07
!BlockEvtYellowSwitch_10 = $10
!BlockEvtGreenSwitch_11 = $11

; -----------------------------------------------------------------------------
; Block Contents ($05)
; -----------------------------------------------------------------------------

!BlockObjNothing_00 = $00
!BlockObjMushroom_01 = $01
!BlockObjFlower_02 = $02
!BlockObjStar_03 = $03
!BlockObjFeather_04 = $04
!BlockObj1Up_05 = $05
!BlockObjSingleCoin_06 = $06
!BlockObjMultiCoin_07 = $07
!BlockObjVine_08 = $08
!BlockObjGreenKoopa_09 = $09  ; unused
!BlockObjPSwitch_0A = $0A
!BlockObjKeyWingsBalloon_0B = $0B
!BlockObjYoshiEgg_0C = $0C
!BlockObjGreenShell_0D = $0D
!BlockObjChangingItem_0E = $0E ; unused
!BlockObjDirCoins_0F = $0F
!BlockObjStunnedKey_10 = $10 ; unused

; -----------------------------------------------------------------------------
; Block Behaviours (derived from $05)
; -----------------------------------------------------------------------------

!BlkBehaviourNothing_00 = !BlockObjNothing_00
!BlkBehaviourMushroom_02 = 2*!BlockObjMushroom_01
!BlkBehaviourFlowerIfBig_05 = 2*!BlockObjFlower_02+1
!BlkBehaviourStar_06 = 2*!BlockObjStar_03
!BlkBehaviourStar2_07 = 2*!BlockObjStar_03+1
!BlkBehaviourFeather_08 = 2*!BlockObjFeather_04
!BlkBehaviourFeatherIfBig_09 = 2*!BlockObjFeather_04+1
!BlkBehaviour1Up_0A = 2*!BlockObj1Up_05
!BlkBehaviourSingleCoin_0C = 2*!BlockObjSingleCoin_06
!BlkBehaviourMultiCoin_0E = 2*!BlockObjMultiCoin_07
!BlkBehaviourVine_10 = 2*!BlockObjVine_08
!BlkBehaviourPSwitch_14 = 2*!BlockObjPSwitch_0A
!BlkBehaviourKeyWingsBalloon_16 = 2*!BlockObjKeyWingsBalloon_0B
!BlkBehaviourYoshiEgg_18 = 2*!BlockObjYoshiEgg_0C
!BlkBehaviourGreenShell_1A = 2*!BlockObjGreenShell_0D
!BlkBehaviourDirCoins_1E = 2*!BlockObjDirCoins_0F
!BlkBehaviourFlowerFeatherStar_80 = $80 ; Map16 $111
!BlkBehaviourStar1UpVine_81 = $81       ; Map16 $11A
!BlkBehaviourGreenStarBlock_FF = $FF    ; Map16 $12D
