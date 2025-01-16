@ Ghostwalker: Grants absolute evasion.

.equ GhostwalkerID, SkillTester+4
.thumb
push {r4-r5,lr}
@r0 is the attacker
@r1 is the defender
mov r4, r0				@r4 = Attacker
mov r5, r1				@r5 = Defender

CheckSkill1:
@now check for the skill
ldr r2, SkillTester		@r2 = SkillTester
mov lr, r2				@lr = SkillTester
ldr r1, GhostwalkerID	@r1 = GhostwalkerID
.short 0xf800
cmp r0, #0
beq CheckSkill2

@Give defender 0 hit
mov 	r0, r5		@r0 = defender
add     r0,#0x60    @Move to the defender's HIT.
mov     r3,#0     	@Set Hit to 0.
strh    r3,[r0]     @Store.

CheckSkill2:
@now check for the skill
mov r0, r5				@r0 = Defender
ldr r2, SkillTester		@r2 = SkillTester
mov lr, r2				@lr = SkillTester
ldr r1, GhostwalkerID	@r1 = GhostwalkerID
.short 0xf800
cmp r0, #0
beq Done

@Give attacker 0 hit
mov 	r0, r4		@r0 = attacker
add     r0,#0x60    @Move to the defender's HIT.
mov     r3,#0     	@Set Hit to 0.
strh    r3,[r0]     @Store.

Done:
pop {r4-r5}
pop {r0}
bx r0
.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD GhostwalkerID
