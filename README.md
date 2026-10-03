This is a rewrite on top of https://github.com/Sir-Walrus/smw-irq

At the moment, we're updating it very aggressively, directly on the master branch.

We're still testing the style below. The main objective is to have a clear view of the hex values and semantics at the same time, making trace logging and debugging easier. Finally, we want to document where glitches happen in the code and be able to predict new ones.
/
## Documentation Style

1. Spaces are used for indentation, with a width of 4.
2. `\n` (LF) is the preferred line ending for consistency.
3. Labels and code should never share a line.
4. Labels should use the `snake_case_0190FA` format, with the address code at the end.
5. Prefer dotted sublabels whenever possible.
6. A newline may be added after jumps, subroutines, forced branches, or branches into other subroutines.
7. Try to limit lines to 120 characters, unless the comment cannot be broken into the next lines.
8. Lines missing an address should have the address added.
9. RAM defines should currently use the `CamelCase_09AF` format.
10. It is advisable to use multiple defines for the same address, if they have different semantics.
11. Constants should be used for known values of important addresses, using this format `!StatusNormal_08 = $08`
12. Abbreviations should be avoided where possible to enforce maximum consistency. Exceptions are listed below.
13. Use +/- labels sensibly, when they are next to each other or are part of a unidirectional sequence.
14. Opcodes and hexadecimal numbers should be written in uppercase.
15. Documentation should be semantic. Only during complicated operations should it explain the opcodes.
16. All labels should receive meaningful names. Code/data labels should be gradually removed.
17. Numeric addresses should be converted to labels whenever possible, especially those used in DMA.


## The comment structure:

The comment structure is rather simple and is rather basic. The backslash (\) is used to represent a new level of code,
the pipe (|) is used to designate continuation of the current code level, and finally the forwardslash (/) closes a 
level of code.  You may nest comments up to two levels deep.  An example of the comment structure looks something like
this:

```asm
(code section)                    (address column) (comment wall) 
start_SPC_upload_00811D:                    ;        \
    LDA.b #$FF                              ;$00811D |\ Tell the SPC to enable the upload routine
    STA.w $2141                             ;$00811F |/
    JSR upload_data_to_SPC_0080F7           ;$008122 | Enter the SNES side SPC upload
    LDX.b #$03                              ;$008125 |\ 
-   STZ.w $2140,X                           ;$008127 | | Clear out all SPC I/O ports and mirrors
    STZ.w SPCIO0_1DF9,X                     ;$00812A | |
    STZ.w LastUsedMusic_1DFF-2,X            ;$00812D | |
    DEX                                     ;$008130 | |
    BPL -                                   ;$008131 |/
SPC_upload_return:                          ;        |
    RTS                                     ;$008133 /
```

## Acceptable abbreviations:
Abbreviations are enforced on the following words for maximum consistency and ease of typing.  Abbreviations are
carefully chosen to avoid ambiguity and not compromise readability in any way.

OW = overworld
BG = background
gfx = graphics
info = information
init = initialization
spr = sprite

> TODO: list all correctly.

# Acknowledgements

Alcaro, p4plus2, Mario
https://github.com/Sir-Walrus/smw-irq

Ankouno
https://github.com/Ankouno/SMW-Data/blob/master/Disassembly/bank_01.asm

IsoFrieze, et al
https://github.com/IsoFrieze/SMWDisX