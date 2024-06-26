@Born Brawler: Grants +3 damage per adjacent enemy.
@Uses Tantivy and Infiltrator as a base.
.equ GetUnitsInRange, SkillTester+4
.equ BornBrawlerID, GetUnitsInRange+4
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
ldr r1, BornBrawlerID
.short 0xf800
cmp r0, #0
beq Done

@Check if there are adjacent
ldr r0, GetUnitsInRange
mov lr, r0
mov r0, r4 		@attacker
mov r1, #3 		@enemy faction
mov r2, #1 		@range
.short 0xf800
cmp r0, #0
beq Done

mov r2, #0x0
Loop:
ldrb r1, [r0, r2]
cmp  r1, #0x0
beq  ProcessCount
add  r2, #0x1
b Loop				@r2 = Count of adjacent enemies

ProcessCount:
mov r3, r2
add r3, r2			@r3 = 2 * Count of adjacent enemies
add r3, r2			@r3 = 3 * Count of adjacent enemies

mov 	r0, r4		@r0 = Address of Attacker
add     r0,#0x5A    @Move to the attacker's ATK.
ldrh    r1,[r0]     @Load the attacker's ATK into r1.
add     r1, r3   	@add 3 * Count of adjacent enemies
strh    r1,[r0]     @Store.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
SkillTester:
@ POIN SkillTester
@ POIN GetUnitsInRange
@ WORD TantivyID
