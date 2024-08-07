// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CJsonRoot _$CJsonRootFromJson(Map<String, dynamic> json) => CJsonRoot(
      types: (json['types'] as List<dynamic>)
          .map((e) => CJsonType.fromJson(e as Map<String, dynamic>))
          .toList(),
      flavors: (json['flavors'] as List<dynamic>)
          .map((e) => CJsonFlavor.fromJson(e as Map<String, dynamic>))
          .toList(),
      descriptors: (json['descriptors'] as List<dynamic>)
          .map((e) => CJsonDescriptor.fromJson(e as Map<String, dynamic>))
          .toList(),
      foci: (json['foci'] as List<dynamic>)
          .map((e) => CJsonFocus.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => CJsonAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      cyphers: (json['cyphers'] as List<dynamic>)
          .map((e) => CJsonCypher.fromJson(e as Map<String, dynamic>))
          .toList(),
      cypherTables: (json['cypher_tables'] as List<dynamic>)
          .map((e) => CJsonRollTable.fromJson(e as Map<String, dynamic>))
          .toList(),
      artifacts: (json['artifacts'] as List<dynamic>)
          .map((e) => CJsonArtifact.fromJson(e as Map<String, dynamic>))
          .toList(),
      creatures: (json['creatures'] as List<dynamic>)
          .map((e) => CJsonCreature.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipment: (json['equipment'] as List<dynamic>)
          .map((e) => CJsonEquipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonRootToJson(CJsonRoot instance) => <String, dynamic>{
      'types': instance.types,
      'flavors': instance.flavors,
      'descriptors': instance.descriptors,
      'foci': instance.foci,
      'abilities': instance.abilities,
      'cyphers': instance.cyphers,
      'cypher_tables': instance.cypherTables,
      'artifacts': instance.artifacts,
      'creatures': instance.creatures,
      'equipment': instance.equipment,
    };

CJsonAbility _$CJsonAbilityFromJson(Map<String, dynamic> json) => CJsonAbility(
      name: json['name'] as String,
      cost: json['cost'] as int?,
      pool: (json['pool'] as List<dynamic>).map((e) => e as String).toList(),
      additionalCost: json['additional_cost'] as String?,
      costRendered: json['cost_rendered'] as String,
      tier: json['tier'] as String?,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      references: (json['references'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CJsonAbilityToJson(CJsonAbility instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'pool': instance.pool,
      'additional_cost': instance.additionalCost,
      'cost_rendered': instance.costRendered,
      'tier': instance.tier,
      'category': instance.category,
      'description': instance.description,
      'references': instance.references,
    };

CJsonAbilityRef _$CJsonAbilityRefFromJson(Map<String, dynamic> json) =>
    CJsonAbilityRef(
      name: json['name'] as String,
      tier: json['tier'] as int,
      preselected: json['preselected'] as bool,
    );

Map<String, dynamic> _$CJsonAbilityRefToJson(CJsonAbilityRef instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tier': instance.tier,
      'preselected': instance.preselected,
    };

CJsonBasicAbility _$CJsonBasicAbilityFromJson(Map<String, dynamic> json) =>
    CJsonBasicAbility(
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CJsonBasicAbilityToJson(CJsonBasicAbility instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CJsonType _$CJsonTypeFromJson(Map<String, dynamic> json) => CJsonType(
      name: json['name'] as String,
      intrusions: (json['intrusions'] as List<dynamic>)
          .map((e) => CJsonBasicAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      statPool: Map<String, int>.from(json['stat_pool'] as Map),
      background:
          CJsonRollTable.fromJson(json['background'] as Map<String, dynamic>),
      specialAbilitiesPerTier: (json['special_abilities_per_tier']
              as List<dynamic>)
          .map((e) =>
              CJsonSpecialAbilitiesAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => CJsonBasicAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialAbilities: (json['special_abilities'] as List<dynamic>)
          .map((e) => CJsonAbilityRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonTypeToJson(CJsonType instance) => <String, dynamic>{
      'name': instance.name,
      'intrusions': instance.intrusions,
      'stat_pool': instance.statPool,
      'background': instance.background,
      'special_abilities_per_tier': instance.specialAbilitiesPerTier,
      'abilities': instance.abilities,
      'special_abilities': instance.specialAbilities,
    };

CJsonSpecialAbilitiesAmount _$CJsonSpecialAbilitiesAmountFromJson(
        Map<String, dynamic> json) =>
    CJsonSpecialAbilitiesAmount(
      tier: json['tier'] as int,
      specialAbilities: json['special_abilities'] as int,
    );

Map<String, dynamic> _$CJsonSpecialAbilitiesAmountToJson(
        CJsonSpecialAbilitiesAmount instance) =>
    <String, dynamic>{
      'tier': instance.tier,
      'special_abilities': instance.specialAbilities,
    };

CJsonFlavor _$CJsonFlavorFromJson(Map<String, dynamic> json) => CJsonFlavor(
      name: json['name'] as String,
      description: json['description'] as String,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => CJsonAbilityRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonFlavorToJson(CJsonFlavor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'abilities': instance.abilities,
    };

CJsonDescriptor _$CJsonDescriptorFromJson(Map<String, dynamic> json) =>
    CJsonDescriptor(
      name: json['name'] as String,
      description: json['description'] as String,
      characteristics: (json['characteristics'] as List<dynamic>)
          .map((e) => CJsonBasicAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CJsonDescriptorToJson(CJsonDescriptor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'characteristics': instance.characteristics,
      'links': instance.links,
    };

CJsonFocus _$CJsonFocusFromJson(Map<String, dynamic> json) => CJsonFocus(
      name: json['name'] as String,
      description: json['description'] as String,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => CJsonAbilityRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      intrusions: json['intrusions'] as String?,
    );

Map<String, dynamic> _$CJsonFocusToJson(CJsonFocus instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'abilities': instance.abilities,
      'intrusions': instance.intrusions,
    };

CJsonCypher _$CJsonCypherFromJson(Map<String, dynamic> json) => CJsonCypher(
      name: json['name'] as String,
      effect: json['effect'] as String,
      form: json['form'] as String?,
      levelDice: json['level_dice'] as String?,
      levelMod: json['level_mod'] as int,
      options: (json['options'] as List<dynamic>)
          .map((e) => CJsonRollTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonCypherToJson(CJsonCypher instance) =>
    <String, dynamic>{
      'name': instance.name,
      'effect': instance.effect,
      'form': instance.form,
      'level_dice': instance.levelDice,
      'level_mod': instance.levelMod,
      'options': instance.options,
    };

CJsonRollTable _$CJsonRollTableFromJson(Map<String, dynamic> json) =>
    CJsonRollTable(
      name: json['name'] as String?,
      table: (json['table'] as List<dynamic>)
          .map((e) => CJsonRollEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonRollTableToJson(CJsonRollTable instance) =>
    <String, dynamic>{
      'name': instance.name,
      'table': instance.table,
    };

CJsonRollEntry _$CJsonRollEntryFromJson(Map<String, dynamic> json) =>
    CJsonRollEntry(
      start: json['start'] as int,
      end: json['end'] as int,
      entry: json['entry'] as String,
    );

Map<String, dynamic> _$CJsonRollEntryToJson(CJsonRollEntry instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'entry': instance.entry,
    };

CJsonArtifact _$CJsonArtifactFromJson(Map<String, dynamic> json) =>
    CJsonArtifact(
      name: json['name'] as String,
      levelDice: json['level_dice'] as String?,
      levelMod: json['level_mod'] as int,
      form: json['form'] as String?,
      depletion: json['depletion'] as String,
      effect: json['effect'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => CJsonRollTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonArtifactToJson(CJsonArtifact instance) =>
    <String, dynamic>{
      'name': instance.name,
      'level_dice': instance.levelDice,
      'level_mod': instance.levelMod,
      'form': instance.form,
      'depletion': instance.depletion,
      'effect': instance.effect,
      'options': instance.options,
    };

CJsonCreature _$CJsonCreatureFromJson(Map<String, dynamic> json) =>
    CJsonCreature(
      name: json['name'] as String,
      kind: json['kind'] as String,
      level: json['level'] as int?,
      description: json['description'] as String,
      motive: json['motive'] as String?,
      environment: json['environment'] as String?,
      health: json['health'] as int?,
      damage: json['damage'] as String?,
      armor: json['armor'] as int,
      movement: json['movement'] as String?,
      modifications: (json['modifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      combat: json['combat'] as String?,
      interactions: json['interactions'] as String?,
      uses: json['uses'] as String?,
      loot: json['loot'] as String?,
      intrusions: json['intrusions'] as String?,
    );

Map<String, dynamic> _$CJsonCreatureToJson(CJsonCreature instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': instance.kind,
      'level': instance.level,
      'description': instance.description,
      'motive': instance.motive,
      'environment': instance.environment,
      'health': instance.health,
      'damage': instance.damage,
      'armor': instance.armor,
      'movement': instance.movement,
      'modifications': instance.modifications,
      'combat': instance.combat,
      'interactions': instance.interactions,
      'uses': instance.uses,
      'loot': instance.loot,
      'intrusions': instance.intrusions,
    };

CJsonEquipment _$CJsonEquipmentFromJson(Map<String, dynamic> json) =>
    CJsonEquipment(
      name: json['name'] as String,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => CJsonEquipmentVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CJsonEquipmentToJson(CJsonEquipment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'variants': instance.variants,
    };

CJsonEquipmentVariant _$CJsonEquipmentVariantFromJson(
        Map<String, dynamic> json) =>
    CJsonEquipmentVariant(
      description: json['description'] as String,
      notes: (json['notes'] as List<dynamic>).map((e) => e as String).toSet(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
      value: (json['value'] as List<dynamic>).map((e) => e as String).toList(),
      levels: (json['levels'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CJsonEquipmentVariantToJson(
        CJsonEquipmentVariant instance) =>
    <String, dynamic>{
      'description': instance.description,
      'notes': instance.notes.toList(),
      'tags': instance.tags.toList(),
      'value': instance.value,
      'levels': instance.levels,
    };
