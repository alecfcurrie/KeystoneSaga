@Courageous: Grants +3/-3 damage dealt/taken when not adjacent to allies.
@Uses Tantivy as a base.
.equ GetUnitsInRange, SkillTester+4
.equ CourageousID, GetUnitsInRange+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker
ldr r1, CourageousID
.short 0xf800
cmp r0, #0
beq Done

@Check if there are adjacent
ldr r0, GetUnitsInRange
mov lr, r0
mov r0, r4 @attacker
mov r1, #0 @can_trade
mov r2, #1 @range
.short 0xf800
cmp r0, #0
bne Done

mov 	r0, r4
add     r0,#0x5A    @Move to the attacker's ATK.
ldrh    r3,[r0]     @Load the attacker's ATK into r3.
add     r3,#3       @add 3 attack.
strh    r3,[r0]     @Store.

add		r0, #2 			@attacker's DEF/RES
ldrh    r3,[r0]     @Load the attacker's DEF/RES into r3.
add     r3,#3    	@add 3 defense.
strh    r3,[r0]     @Store.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg

SkillTester:
@ POIN SkillTester
@ POIN GetUnitsInRange
@ WORD CourageousID
