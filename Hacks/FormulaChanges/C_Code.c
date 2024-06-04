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
    bu->battleCritRate = GetItemCrit(bu->weapon) + ((bu->unit.skl - 10) / 2);
	
	if (bu->battleCritRate < 0)
        bu->battleCritRate = 0;

    if (UNIT_CATTRIBUTES(&bu->unit) & CA_CRITBONUS)
        bu->battleCritRate += 15;
}

void ComputeBattleUnitDodgeRate(struct BattleUnit* bu) {
    bu->battleDodgeRate = (bu->unit.lck / 2);
}

#endif 