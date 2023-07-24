// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animalpieces.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimalPiecesCollection on Isar {
  IsarCollection<AnimalPieces> get animalPieces => this.collection();
}

const AnimalPiecesSchema = CollectionSchema(
  name: r'AnimalPieces',
  id: 2092957814652421724,
  properties: {
    r'animalName': PropertySchema(
      id: 0,
      name: r'animalName',
      type: IsarType.string,
    ),
    r'pieces': PropertySchema(
      id: 1,
      name: r'pieces',
      type: IsarType.long,
    )
  },
  estimateSize: _animalPiecesEstimateSize,
  serialize: _animalPiecesSerialize,
  deserialize: _animalPiecesDeserialize,
  deserializeProp: _animalPiecesDeserializeProp,
  idName: r'id',
  indexes: {
    r'animalName': IndexSchema(
      id: -4526056967538600938,
      name: r'animalName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'animalName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'pieces': IndexSchema(
      id: -4053813176391248480,
      name: r'pieces',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pieces',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _animalPiecesGetId,
  getLinks: _animalPiecesGetLinks,
  attach: _animalPiecesAttach,
  version: '3.1.0+1',
);

int _animalPiecesEstimateSize(
  AnimalPieces object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animalName.length * 3;
  return bytesCount;
}

void _animalPiecesSerialize(
  AnimalPieces object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animalName);
  writer.writeLong(offsets[1], object.pieces);
}

AnimalPieces _animalPiecesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimalPieces(
    animalName: reader.readString(offsets[0]),
    id: id,
    pieces: reader.readLong(offsets[1]),
  );
  return object;
}

P _animalPiecesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _animalPiecesGetId(AnimalPieces object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animalPiecesGetLinks(AnimalPieces object) {
  return [];
}

void _animalPiecesAttach(
    IsarCollection<dynamic> col, Id id, AnimalPieces object) {
  object.id = id;
}

extension AnimalPiecesQueryWhereSort
    on QueryBuilder<AnimalPieces, AnimalPieces, QWhere> {
  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhere> anyPieces() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'pieces'),
      );
    });
  }
}

extension AnimalPiecesQueryWhere
    on QueryBuilder<AnimalPieces, AnimalPieces, QWhereClause> {
  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> animalNameEqualTo(
      String animalName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'animalName',
        value: [animalName],
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause>
      animalNameNotEqualTo(String animalName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalName',
              lower: [],
              upper: [animalName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalName',
              lower: [animalName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalName',
              lower: [animalName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalName',
              lower: [],
              upper: [animalName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> piecesEqualTo(
      int pieces) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pieces',
        value: [pieces],
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> piecesNotEqualTo(
      int pieces) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieces',
              lower: [],
              upper: [pieces],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieces',
              lower: [pieces],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieces',
              lower: [pieces],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieces',
              lower: [],
              upper: [pieces],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> piecesGreaterThan(
    int pieces, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieces',
        lower: [pieces],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> piecesLessThan(
    int pieces, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieces',
        lower: [],
        upper: [pieces],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterWhereClause> piecesBetween(
    int lowerPieces,
    int upperPieces, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieces',
        lower: [lowerPieces],
        includeLower: includeLower,
        upper: [upperPieces],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnimalPiecesQueryFilter
    on QueryBuilder<AnimalPieces, AnimalPieces, QFilterCondition> {
  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'animalName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'animalName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'animalName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalName',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      animalNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'animalName',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> piecesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieces',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      piecesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieces',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition>
      piecesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieces',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterFilterCondition> piecesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieces',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnimalPiecesQueryObject
    on QueryBuilder<AnimalPieces, AnimalPieces, QFilterCondition> {}

extension AnimalPiecesQueryLinks
    on QueryBuilder<AnimalPieces, AnimalPieces, QFilterCondition> {}

extension AnimalPiecesQuerySortBy
    on QueryBuilder<AnimalPieces, AnimalPieces, QSortBy> {
  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> sortByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy>
      sortByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> sortByPieces() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieces', Sort.asc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> sortByPiecesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieces', Sort.desc);
    });
  }
}

extension AnimalPiecesQuerySortThenBy
    on QueryBuilder<AnimalPieces, AnimalPieces, QSortThenBy> {
  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> thenByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy>
      thenByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> thenByPieces() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieces', Sort.asc);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QAfterSortBy> thenByPiecesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieces', Sort.desc);
    });
  }
}

extension AnimalPiecesQueryWhereDistinct
    on QueryBuilder<AnimalPieces, AnimalPieces, QDistinct> {
  QueryBuilder<AnimalPieces, AnimalPieces, QDistinct> distinctByAnimalName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalPieces, AnimalPieces, QDistinct> distinctByPieces() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pieces');
    });
  }
}

extension AnimalPiecesQueryProperty
    on QueryBuilder<AnimalPieces, AnimalPieces, QQueryProperty> {
  QueryBuilder<AnimalPieces, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimalPieces, String, QQueryOperations> animalNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalName');
    });
  }

  QueryBuilder<AnimalPieces, int, QQueryOperations> piecesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieces');
    });
  }
}
