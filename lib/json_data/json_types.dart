import 'package:collection/collection.dart';
import 'package:cypher_system_srd_lookup/render/horizontal_key_values.dart';
import 'package:cypher_system_srd_lookup/render/labeled_link_accordion.dart';
import 'package:cypher_system_srd_lookup/render/labeled_list_accordion.dart';
import 'package:cypher_system_srd_lookup/render/labeled_search_links.dart';
import 'package:cypher_system_srd_lookup/render/link.dart';
import 'package:cypher_system_srd_lookup/render/name_description.dart';
import 'package:cypher_system_srd_lookup/render/paragraph.dart';
import 'package:cypher_system_srd_lookup/render/vertical_key_values.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_types.g.dart';

@JsonSerializable()
class CJsonRoot implements CHasSearchables {
  List<CJsonType> types;
  List<CJsonFlavor> flavors;
  List<CJsonDescriptor> descriptors;
  List<CJsonFocus> foci;
  List<CJsonAbility> abilities;
  List<CJsonCypher> cyphers;

  @JsonKey(name: "cypher_tables")
  List<CJsonRollTable> cypherTables;
  List<CJsonArtifact> artifacts;
  List<CJsonCreature> creatures;
  List<CJsonEquipment> equipment;

  CJsonRoot({
    required this.types,
    required this.flavors,
    required this.descriptors,
    required this.foci,
    required this.abilities,
    required this.cyphers,
    required this.cypherTables,
    required this.artifacts,
    required this.creatures,
    required this.equipment,
  });

  factory CJsonRoot.fromJson(Map<String, dynamic> json) =>
      _$CJsonRootFromJson(json);

  @override
  List<CSearchableCategory> get searchables => [
        CSearchableCategory(category: "Abilities", searchables: abilities),
        CSearchableCategory(category: "Types", searchables: types),
      ];
}

@JsonSerializable()
class CJsonAbility implements CSearchable {
  @override
  String get header => name;

  String name;
  int? cost;
  List<String> pool;

  @JsonKey(name: "additional_cost")
  String? additionalCost;

  @JsonKey(name: "cost_rendered")
  String costRendered;

  String? tier;
  List<String> category;
  String description;
  List<String> references;

  @override
  Iterable<String> searchTextList;

  CJsonAbility({
    required this.name,
    required this.cost,
    required this.pool,
    required this.additionalCost,
    required this.costRendered,
    required this.tier,
    required this.category,
    required this.description,
    required this.references,
  }) : searchTextList = [
          "Name: $name",
          description,
          if (cost != null) "Cost: $costRendered",
          if (tier != null) "Tier: $tier",
          if (category.isNotEmpty) ...category.map((c) => "Category: $c"),
          if (references.isNotEmpty) "Used by: ${references.join(", ")}"
        ];

  factory CJsonAbility.fromJson(Map<String, dynamic> json) =>
      _$CJsonAbilityFromJson(json);

  @override
  Iterable<Widget> getRenderables() {
    return [
      CRenderVerticalKeyValues([
        CNameDescription("Cost", cost == null ? "None" : costRendered),
        if (tier != null) CNameDescription("Tier", tier!),
      ]),
      CRenderParagraph(description),
      if (category.isNotEmpty)
        CRenderLinksParagraph(
          label: category.length == 1 ? "Category" : "Categories",
          textQueries: category
              .map((cat) => CSearchQueryLink(cat, "Category: $cat"))
              .toList(),
        ),
      if (references.isNotEmpty)
        CRenderLinksParagraph(
          label: "Used by",
          textQueries: references
              .map((ref) => CSearchQueryLink(ref, "Name: $ref"))
              .toList(),
        ),
    ];
  }
}

@JsonSerializable()
class CJsonAbilityRef implements CSearchableItem {
  String name;
  int tier;
  bool preselected;

  @override
  String searchText;

  CJsonAbilityRef({
    required this.name,
    required this.tier,
    required this.preselected,
  }) : searchText =
            "Ability: $name (Tier $tier, ${preselected ? "preselected" : "optional"})";

  factory CJsonAbilityRef.fromJson(Map<String, dynamic> json) =>
      _$CJsonAbilityRefFromJson(json);
}

@JsonSerializable()
class CJsonBasicAbility implements CSearchableItem {
  String name;
  String description;

  @override
  String searchText;

  CJsonBasicAbility({
    required this.name,
    required this.description,
  }) : searchText = "$name: $description";

  factory CJsonBasicAbility.fromJson(Map<String, dynamic> json) =>
      _$CJsonBasicAbilityFromJson(json);
}

@JsonSerializable()
class CJsonType implements CSearchable {
  @override
  String get header => name;

  String name;
  List<CJsonBasicAbility> intrusions;

  @JsonKey(name: "stat_pool")
  Map<String, int> statPool;

  CJsonRollTable background;

  @JsonKey(name: "special_abilities_per_tier")
  List<CJsonSpecialAbilitiesAmount> specialAbilitiesPerTier;
  List<CJsonBasicAbility> abilities;

  @JsonKey(name: "special_abilities")
  List<CJsonAbilityRef> specialAbilities;

  @override
  Iterable<String> searchTextList;

  CJsonType({
    required this.name,
    required this.intrusions,
    required this.statPool,
    required this.background,
    required this.specialAbilitiesPerTier,
    required this.abilities,
    required this.specialAbilities,
  }) : searchTextList = [
          "Name: $name",
          ...statPool.entries.map((kvp) => "${kvp.key}: ${kvp.value}"),
          ...abilities.map((a) => a.searchText),
          ...specialAbilities.map((s) => s.searchText),
          ...intrusions.map((i) => i.searchText),
          ...specialAbilitiesPerTier.map((s) => s.searchText),
        ];

  factory CJsonType.fromJson(Map<String, dynamic> json) =>
      _$CJsonTypeFromJson(json);

  @override
  Iterable<Widget> getRenderables() {
    return [
      CRenderHorizontalKeyValues(
        statPool.entries
            .map<CNameDescription>(
                (entry) => CNameDescription(entry.key, entry.value.toString()))
            .toList(),
      ),
      CRenderLabeledListAccordion(
        abilities.map((a) => CNameDescription(a.name, a.description)),
        label: "Traits",
      ),
      CRenderLabeledListAccordion(
        intrusions.map((i) => CNameDescription(i.name, i.description)),
        label: "Intrusions",
      ),
      ...specialAbilitiesPerTier.map(
        (tierAmount) => CRenderLabeledResultLinkAccordion(
          label: "Tier ${tierAmount.tier} Abilities",
          innerLabel: "Take ${tierAmount.specialAbilities}:",
          links: specialAbilities
              .where((a) => a.tier == tierAmount.tier)
              .sorted((a, b) => a.preselected == b.preselected
                  ? 0
                  : a.preselected
                      ? -1
                      : 1)
              .map((a) => CResultLink(
                    "${a.name}${a.preselected ? " (preselected)" : ""}",
                    resultCategory: "Abilities",
                    resultName: a.name,
                  ))
              .toList(),
        ),
      ),
    ];
  }
}

@JsonSerializable()
class CJsonSpecialAbilitiesAmount implements CSearchableItem {
  int tier;

  @JsonKey(name: "special_abilities")
  int specialAbilities;

  @override
  String searchText;

  CJsonSpecialAbilitiesAmount({
    required this.tier,
    required this.specialAbilities,
  }) : searchText = "$specialAbilities special abilities at tier $tier";

  factory CJsonSpecialAbilitiesAmount.fromJson(Map<String, dynamic> json) =>
      _$CJsonAmountFromJson(json);
}

@JsonSerializable()
class CJsonFlavor {
  String name;
  List<CJsonAbilityRef> abilities;

  CJsonFlavor({
    required this.name,
    required this.abilities,
  });

  factory CJsonFlavor.fromJson(Map<String, dynamic> json) =>
      _$CJsonFlavorFromJson(json);
}

@JsonSerializable()
class CJsonDescriptor {
  String name;
  String description;
  List<CJsonBasicAbility> characteristics;
  List<String> links;

  CJsonDescriptor({
    required this.name,
    required this.description,
    required this.characteristics,
    required this.links,
  });

  factory CJsonDescriptor.fromJson(Map<String, dynamic> json) =>
      _$CJsonDescriptorFromJson(json);
}

@JsonSerializable()
class CJsonFocus {
  String name;
  String description;
  List<CJsonAbilityRef> abilities;
  String intrusions;

  CJsonFocus({
    required this.name,
    required this.description,
    required this.abilities,
    required this.intrusions,
  });

  factory CJsonFocus.fromJson(Map<String, dynamic> json) =>
      _$CJsonFocusFromJson(json);
}

@JsonSerializable()
class CJsonCypher {
  String name;
  String? form;

  @JsonKey(name: "level_dice")
  String? levelDice;

  @JsonKey(name: "level_mod")
  int levelMod;

  List<CJsonRollTable> options;

  List<String>? kinds;

  CJsonCypher({
    required this.name,
    required this.form,
    required this.levelDice,
    required this.levelMod,
    required this.options,
    required this.kinds,
  });

  factory CJsonCypher.fromJson(Map<String, dynamic> json) =>
      _$CJsonCypherFromJson(json);
}

@JsonSerializable()
class CJsonRollTable {
  String? name;
  List<CJsonRollEntry> table;

  CJsonRollTable({
    required this.name,
    required this.table,
  });

  factory CJsonRollTable.fromJson(Map<String, dynamic> json) =>
      _$CJsonRollTableFromJson(json);
}

@JsonSerializable()
class CJsonRollEntry {
  int start;
  int end;
  String entry;

  CJsonRollEntry({
    required this.start,
    required this.end,
    required this.entry,
  });

  factory CJsonRollEntry.fromJson(Map<String, dynamic> json) =>
      _$CJsonRollEntryFromJson(json);
}

@JsonSerializable()
class CJsonArtifact {
  String name;

  @JsonKey(name: "level_dice")
  String? levelDice;

  @JsonKey(name: "level_mod")
  int levelMod;

  String form;
  String depletion;
  String effect;
  List<CJsonRollTable> options;

  CJsonArtifact({
    required this.name,
    required this.levelDice,
    required this.levelMod,
    required this.form,
    required this.depletion,
    required this.effect,
    required this.options,
  });

  factory CJsonArtifact.fromJson(Map<String, dynamic> json) =>
      _$CJsonArtifactFromJson(json);
}

@JsonSerializable()
class CJsonCreature {
  String name;
  String kind;
  int? level;
  String description;
  String? motive;
  String? environment;
  int? health;
  String? damage;
  int armor;
  String? movement;
  List<String> modifications;
  String? combat;
  String? interactions;
  String? uses;
  String? loot;
  String? intrusions;

  CJsonCreature({
    required this.name,
    required this.kind,
    required this.level,
    required this.description,
    required this.motive,
    required this.environment,
    required this.health,
    required this.damage,
    required this.armor,
    required this.movement,
    required this.modifications,
    required this.combat,
    required this.interactions,
    required this.uses,
    required this.loot,
    required this.intrusions,
  });

  factory CJsonCreature.fromJson(Map<String, dynamic> json) =>
      _$CJsonCreatureFromJson(json);
}

@JsonSerializable()
class CJsonEquipment {
  String name;
  List<CJsonEquipmentVariant> variants;

  CJsonEquipment({
    required this.name,
    required this.variants,
  });

  factory CJsonEquipment.fromJson(Map<String, dynamic> json) =>
      _$CJsonEquipmentFromJson(json);
}

@JsonSerializable()
class CJsonEquipmentVariant {
  String description;
  Set<String> notes;
  Set<String> tags;
  List<String> value;
  List<int> levels;

  CJsonEquipmentVariant({
    required this.description,
    required this.notes,
    required this.tags,
    required this.value,
    required this.levels,
  });

  factory CJsonEquipmentVariant.fromJson(Map<String, dynamic> json) =>
      _$CJsonEquipmentVariantFromJson(json);
}
