//---------------------------------------------------------------------------------------
//  AUTHOR:  NotSoLoneWolf
//  PURPOSE: Creates schematic templates for the disguises
//---------------------------------------------------------------------------------------
//  WOTCStrategyOverhaul Team
//---------------------------------------------------------------------------------------

class X2Item_DisguiseSchematics extends X2Item_DefaultSchematics;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Schematics;
	
	Schematics.AddItem(CreateCivilianDisguiseSchematic());
	Schematics.AddItem(CreateAdventDisguiseSchematic());
	Schematics.AddItem(CreateHolographicDisguiseSchematic());

	return Schematics;
}

static function X2DataTemplate CreateCivilianDisguiseSchematic()
{
	local X2SchematicTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'CivilianDisguise_Schematic');

	Template.ItemCat = 'armor';
	Template.strImage = "img:///UILibrary_DisguiseInventory.Inv_Disguise_Civilian";
	Template.PointsToComplete = 0;
	Template.Tier = 0;
	Template.OnBuiltFn = UpgradeItems;

	Template.ReferenceItemTemplate = 'CivilianDisguise';
	Template.HideIfPurchased = 'HolographicDisguise';

	return Template;
}

static function X2DataTemplate CreateAdventDisguiseSchematic()
{
	local X2SchematicTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'AdventDisguise_Schematic');

	Template.ItemCat = 'armor';
	Template.strImage = "img:///UILibrary_DisguiseInventory.Inv_Disguise_Advent";
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;

	Template.ReferenceItemTemplate = 'AdventDisguise';
	Template.HideIfPurchased = 'HolographicDisguise';

	return Template;
}

static function X2DataTemplate CreateHolographicDisguiseSchematic()
{
	local X2SchematicTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'HolographicDisguise_Schematic');

	Template.ItemCat = 'armor';
	Template.strImage = "img:///UILibrary_DisguiseInventory.Inv_Disguise_Holo";
	Template.PointsToComplete = 0;
	Template.Tier = 2;
	Template.OnBuiltFn = UpgradeItems;

	Template.ReferenceItemTemplate = 'HolographicDisguise';

	return Template;
}
