.thumb
.equ GetItemUseDescId,		0x8017531
.equ GetStringFromIndex,	0x800A241
.equ ReturnIfAttackStick,	0x801E8A5
.equ ReturnIfHealStick,		0x801E813
.equ GetItemType,			0x8017549

push 	{r6}
mov		r4, r0
ldr		r6, =GetItemUseDescId
bl		BXR6
cmp		r0, #0x0
beq		NoItemUseDescription

DisplayItemUseDescription:
@and this is just stuff we replaced
ldr		r6, =GetStringFromIndex
bl		BXR6
pop		{r6}
mov		r4, r0
mov		r5, #0x0
ldr		r7, [sp, #0x4]
add		r7, #0x42
ldr		r0, =ReturnIfHealStick
bx 		r0

NoItemUseDescription:
push	{r0-r3}
mov		r0, r4
ldr		r6, =GetItemType
bl		BXR6
mov		r6, r0
pop		{r0-r3}
cmp		r6, #0x4 @check if it's actually a staff first
bne		DisplayItemUseDescription

ldr		r0, =ReturnIfAttackStick
pop		{r6}
bx 		r0

BXR6:
bx 		r6
