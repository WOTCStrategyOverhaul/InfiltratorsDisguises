//---------------------------------------------------------------------------------------
//  AUTHOR:  ArcaneData
//  PURPOSE: Creates abilities for infiltration armors.
//---------------------------------------------------------------------------------------
//  WOTCStrategyOverhaul Team
//---------------------------------------------------------------------------------------

class X2Ability_DisguiseAbilitySet extends X2Ability_ItemGrantedAbilitySet config(GameCore);

var config int CIVILIAN_DISGUISE_HEALTH_BONUS;
var config int CIVILIAN_DISGUISE_MOBILITY_BONUS;
var config float CIVILIAN_DISGUISE_DETECTION_MODIFIER;

var config int ADVENT_DISGUISE_HEALTH_BONUS;
var config int ADVENT_DISGUISE_MOBILITY_BONUS;
var config float ADVENT_DISGUISE_DETECTION_MODIFIER;

var config int HOLOGRAPHIC_DISGUISE_HEALTH_BONUS;
var config int HOLOGRAPHIC_DISGUISE_MOBILITY_BONUS;
var config float HOLOGRAPHIC_DISGUISE_DETECTION_MODIFIER;

var config int UNPROTECTED_DAMAGE_CHANCE;
var config int UNPROTECTED_DAMAGE_AMOUNT;

var localized string strTowerDetectionImmunityName;
var localized string strTowerDetectionImmunityDesc;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CivilianDisguiseStats());
	Templates.AddItem(AdventDisguiseStats());
	Templates.AddItem(HolographicDisguiseStats());
	
	Templates.AddItem(UnprotectedAbility());

	return Templates;
}

static function X2AbilityTemplate CivilianDisguiseStats()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'CivilianDisguiseStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.CIVILIAN_DISGUISE_HEALTH_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.CIVILIAN_DISGUISE_MOBILITY_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_DetectionModifier, default.CIVILIAN_DISGUISE_DETECTION_MODIFIER);

	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate AdventDisguiseStats()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AdventDisguiseStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.ADVENT_DISGUISE_HEALTH_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.ADVENT_DISGUISE_MOBILITY_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_DetectionModifier, default.ADVENT_DISGUISE_DETECTION_MODIFIER);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	Template.AddTargetEffect(CreateTowerDetectionImmunityDisplayEffect());

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate HolographicDisguiseStats()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HolographicDisguiseStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.HOLOGRAPHIC_DISGUISE_HEALTH_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HOLOGRAPHIC_DISGUISE_MOBILITY_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_DetectionModifier, default.HOLOGRAPHIC_DISGUISE_DETECTION_MODIFIER);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	Template.AddTargetEffect(CreateTowerDetectionImmunityDisplayEffect());

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate UnprotectedAbility()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger Trigger;
	local X2Effect_Unprotected DamageModifier;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ID_Unprotected'); // TODO: need ability tags to replace numbers in the loc
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sectoid_meleevulnerability"; // TODO: need a suitable icon
	
	Template.AbilityTargetStyle = default.SelfTarget;
	
	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	DamageModifier = new class'X2Effect_Unprotected';
	DamageModifier.BuildPersistentEffect(1, true, true, true);
	DamageModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
	DamageModifier.ExtraDamageAmount = default.UNPROTECTED_DAMAGE_AMOUNT;
	DamageModifier.ExtraDamageChance = default.UNPROTECTED_DAMAGE_CHANCE;
	Template.AddTargetEffect(DamageModifier);

	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = true;
	Template.bDontDisplayInAbilitySummary = false;
	Template.AbilitySourceName = 'eAbilitySource_Item';

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

// A display-only effect/passive to show in the passives view
// The real change is done in X2AbilityTemplateManager::AbilityRetainsConcealmentVsInteractives
static function X2Effect_Persistent CreateTowerDetectionImmunityDisplayEffect ()
{
	local X2Effect_Persistent TowerDetectionImmunityEffect;

	TowerDetectionImmunityEffect = new class'X2Effect_Persistent';
	TowerDetectionImmunityEffect.BuildPersistentEffect(1, true, false, false);
	TowerDetectionImmunityEffect.SetDisplayInfo(ePerkBuff_Passive, default.strTowerDetectionImmunityName, default.strTowerDetectionImmunityDesc, "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Infiltration");

	return TowerDetectionImmunityEffect;
}
