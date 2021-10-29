class X2DownloadableContentInfo_InfiltratorsDisguises extends X2DownloadableContentInfo;

struct ArmorUtilitySlotsModifier
{
	var name ArmorTemplate;
	var int Mod;
};

var config(GameCore) array<ArmorUtilitySlotsModifier> ArmorUtilitySlotsMods;

//////////////////////
/// DLC (HL) HOOKS ///
//////////////////////

static function GetNumUtilitySlotsOverride (out int NumUtilitySlots, XComGameState_Item EquippedArmor, XComGameState_Unit UnitState, XComGameState CheckGameState)
{
	local int i;

	if (EquippedArmor != none)
	{
		i = default.ArmorUtilitySlotsMods.Find('ArmorTemplate', EquippedArmor.GetMyTemplateName());

		if (i != INDEX_NONE)
		{
			NumUtilitySlots += default.ArmorUtilitySlotsMods[i].Mod;
		}
	}
}

static function bool AbilityTagExpandHandler(string InString, out string OutString)
{
	local name TagText;
    
	TagText = name(InString);

	switch (TagText)
	{
	case 'UNPROTECTED_DAMAGE_CHANCE':
		OutString = string(class'X2Ability_DisguiseAbilitySet'.default.UNPROTECTED_DAMAGE_CHANCE);
		return true;
	case 'UNPROTECTED_DAMAGE_AMOUNT':
		OutString = string(class'X2Ability_DisguiseAbilitySet'.default.UNPROTECTED_DAMAGE_AMOUNT);
		return true;
	default: 
		return false;
	}
}
