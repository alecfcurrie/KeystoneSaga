#include "C_Code.h" // headers 

//#define VANILLA_VERSION 

#ifdef VANILLA_VERSION 
	// Speed*2 + luck 
void ComputeBattleUnitAvoidRate(struct BattleUnit* bu) {
    bu->battleAvoidRate = (bu->battleSpeed * 2) + bu->terrainAvoid + (bu->unit.lck);

    if (bu->battleAvoidRate < 0)
        bu->battleAvoidRate = 0;
}

#else 
	// Speed + (1/2 luck) 
void ComputeBattleUnitAvoidRate(struct BattleUnit* bu) {
    bu->battleAvoidRate = (bu->battleSpeed * 3 / 2) + bu->terrainAvoid + (bu->unit.lck / 2);

    if (bu->battleAvoidRate < 0)
        bu->battleAvoidRate = 0;
}

void ComputeBattleUnitHitRate(struct BattleUnit* bu) {
    bu->battleHitRate = (bu->unit.skl * 3 / 2) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
}

void ComputeBattleUnitCritRate(struct BattleUnit* bu) {
	short skillBonus = ((bu->unit.skl - 10) / 2);
	
	if (skillBonus < 0)
        skillBonus = 0;
	
    bu->battleCritRate = GetItemCrit(bu->weapon) + skillBonus;

    if (UNIT_CATTRIBUTES(&bu->unit) & CA_CRITBONUS)
        bu->battleCritRate += 15;
}

void ComputeBattleUnitDodgeRateNew(struct BattleUnit* bu) { //New because function is not long enough for lyn hook
   bu->battleDodgeRate = (bu->unit.lck / 2);
}

#endif 