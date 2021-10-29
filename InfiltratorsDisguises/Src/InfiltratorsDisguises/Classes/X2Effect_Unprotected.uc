class X2Effect_Unprotected extends X2Effect_Persistent;

var int ExtraDamageAmount;
var int ExtraDamageChance;

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	// not in damage preview
	if (NewGameState != none)
	{
		// original attack didn't miss and dealt some damage
		if (AppliedData.AbilityInputContext.PrimaryTarget.ObjectID > 0 && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) && CurrentDamage != 0)
		{
			if (`SYNC_RAND_STATIC(100) < ExtraDamageChance)
			{
				return ExtraDamageAmount;
			}
		}
	}

	return 0;
}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}
