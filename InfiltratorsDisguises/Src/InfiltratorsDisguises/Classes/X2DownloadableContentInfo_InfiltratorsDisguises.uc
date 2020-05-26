class X2DownloadableContentInfo_InfiltratorsDisguises extends X2DownloadableContentInfo;

struct ArmorUtilitySlotsModifier
{
	var name ArmorTemplate;
	var int Mod;
};

var config(GameCore) array<ArmorUtilitySlotsModifier> ArmorUtilitySlotsMods;

static event OnPostTemplatesCreated ()
{
	local array<X2DataTemplate> DifficultyVariants;
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ArmorTemplate ArmorTemplate;
	local X2DataTemplate DataTemplate;

	if (class'IDHelpers'.static.IsDLCLoaded('CovertInfiltration')) return;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplateManager.FindDataTemplateAllDifficulties('CivilianDisguise', DifficultyVariants);
	foreach DifficultyVariants(DataTemplate)
	{
		ArmorTemplate = X2ArmorTemplate(DataTemplate);

		if (ArmorTemplate == none)
		{
			`REDSCREEN(DataTemplate.Name @ "is not an X2ArmorTemplate");
			continue;
		}

		ArmorTemplate.Abilities.AddItem('Stealth');
	}
	
	ItemTemplateManager.FindDataTemplateAllDifficulties('AdventDisguise', DifficultyVariants);
	foreach DifficultyVariants(DataTemplate)
	{
		ArmorTemplate = X2ArmorTemplate(DataTemplate);

		if (ArmorTemplate == none)
		{
			`REDSCREEN(DataTemplate.Name @ "is not an X2ArmorTemplate");
			continue;
		}

		ArmorTemplate.Abilities.AddItem('Stealth');
	}
	
	ItemTemplateManager.FindDataTemplateAllDifficulties('HolographicDisguise', DifficultyVariants);
	foreach DifficultyVariants(DataTemplate)
	{
		ArmorTemplate = X2ArmorTemplate(DataTemplate);

		if (ArmorTemplate == none)
		{
			`REDSCREEN(DataTemplate.Name @ "is not an X2ArmorTemplate");
			continue;
		}

		ArmorTemplate.Abilities.AddItem('Stealth');
	}
}

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