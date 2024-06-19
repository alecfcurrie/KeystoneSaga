#include "C_Code.h" // headers 

int GetLevelDifference(struct Unit* actor, struct Unit* target) {
	int levelDifference;
	
	levelDifference = GetUnitExpLevel(target);
    levelDifference = levelDifference - GetUnitExpLevel(actor);
    
	return levelDifference;
}


int GetChipExpFromLevelDifference(int levelDifference) {
	/* 
	EXP Formula: 
	10 + 7/3x
	Minimum EXP: 0
	Maximum EXP: 17
	*/
	int result;
	
	result = 10 + ((7 * levelDifference) / 3);
	
	if (result < 0)
		result = 0;
	if (result > 17)
		result = 17;
	
	return result;
}

int GetBossKillExpBonus(struct Unit* target, int levelDifference) {
	
	int result = 0;
	
	if (UNIT_CATTRIBUTES(target) & CA_BOSS) {
        result += 15 + (levelDifference * 2);
		if (result < 0)
			result = 0;
	}
	
    return result;
}

int GetKillExpFromLevelDifference(struct Unit* target, int levelDifference) {
	/* 
	EXP Formula: 
	- For 5 levels higher or more -> 1
	- Between 4 levels higher and 4 levels lower inclusive -> 7x+36
	- Between 4 levels lower and 7 levels lower inclusive -> 12x+11
	- For 7 levels lower or more -> 100
	*/
	int result;
	
	if (levelDifference <= 4)
		result = (7 * levelDifference + 36);
	else
		result = (12 * levelDifference +16);
	
	result += GetBossKillExpBonus(target, levelDifference);
	
	if (result < 1)
		result = 1;
	if (result > 100)
		result = 100;
	
	return result;
}

int GetBattleUnitExpGain(struct BattleUnit* actor, struct BattleUnit* target) {
    int result;

    if (!CanBattleUnitGainLevels(actor) || (actor->unit.curHP == 0) || UNIT_CATTRIBUTES(&target->unit) & CA_NEGATE_LETHALITY || !actor->nonZeroDamage) {
        return 0;
	}
	
	int levelDifference = GetLevelDifference(&actor->unit, &target->unit);
	
	if ((&target->unit)->curHP != 0)
		result = GetChipExpFromLevelDifference(levelDifference);
	else
		result = GetKillExpFromLevelDifference(&target->unit, levelDifference);

    return result;
}