// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_notifications.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActiveNotificationsCollection on Isar {
  IsarCollection<ActiveNotifications> get activeNotifications =>
      this.collection();
}

const ActiveNotificationsSchema = CollectionSchema(
  name: r'ActiveNotifications',
  id: -6344704786573627756,
  properties: {
    r'notificationIds': PropertySchema(
      id: 0,
      name: r'notificationIds',
      type: IsarType.stringList,
    )
  },
  estimateSize: _activeNotificationsEstimateSize,
  serialize: _activeNotificationsSerialize,
  deserialize: _activeNotificationsDeserialize,
  deserializeProp: _activeNotificationsDeserializeProp,
  idName: r'taskid',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _activeNotificationsGetId,
  getLinks: _activeNotificationsGetLinks,
  attach: _activeNotificationsAttach,
  version: '3.1.0+1',
);

int _activeNotificationsEstimateSize(
  ActiveNotifications object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.notificationIds.length * 3;
  {
    for (var i = 0; i < object.notificationIds.length; i++) {
      final value = object.notificationIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _activeNotificationsSerialize(
  ActiveNotifications object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.notificationIds);
}

ActiveNotifications _activeNotificationsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActiveNotifications(
    notificationIds: reader.readStringList(offsets[0]) ?? [],
    taskid: id,
  );
  return object;
}

P _activeNotificationsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activeNotificationsGetId(ActiveNotifications object) {
  return object.taskid;
}

List<IsarLinkBase<dynamic>> _activeNotificationsGetLinks(
    ActiveNotifications object) {
  return [];
}

void _activeNotificationsAttach(
    IsarCollection<dynamic> col, Id id, ActiveNotifications object) {
  object.taskid = id;
}

extension ActiveNotificationsQueryWhereSort
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QWhere> {
  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhere>
      anyTaskid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActiveNotificationsQueryWhere
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QWhereClause> {
  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhereClause>
      taskidEqualTo(Id taskid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: taskid,
        upper: taskid,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhereClause>
      taskidNotEqualTo(Id taskid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: taskid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: taskid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: taskid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: taskid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhereClause>
      taskidGreaterThan(Id taskid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: taskid, includeLower: include),
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhereClause>
      taskidLessThan(Id taskid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: taskid, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterWhereClause>
      taskidBetween(
    Id lowerTaskid,
    Id upperTaskid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerTaskid,
        includeLower: includeLower,
        upper: upperTaskid,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActiveNotificationsQueryFilter on QueryBuilder<ActiveNotifications,
    ActiveNotifications, QFilterCondition> {
  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationIds',
        value: '',
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationIds',
        value: '',
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      notificationIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      taskidEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      taskidGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      taskidLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterFilterCondition>
      taskidBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActiveNotificationsQueryObject on QueryBuilder<ActiveNotifications,
    ActiveNotifications, QFilterCondition> {}

extension ActiveNotificationsQueryLinks on QueryBuilder<ActiveNotifications,
    ActiveNotifications, QFilterCondition> {}

extension ActiveNotificationsQuerySortBy
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QSortBy> {}

extension ActiveNotificationsQuerySortThenBy
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QSortThenBy> {
  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterSortBy>
      thenByTaskid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskid', Sort.asc);
    });
  }

  QueryBuilder<ActiveNotifications, ActiveNotifications, QAfterSortBy>
      thenByTaskidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskid', Sort.desc);
    });
  }
}

extension ActiveNotificationsQueryWhereDistinct
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QDistinct> {
  QueryBuilder<ActiveNotifications, ActiveNotifications, QDistinct>
      distinctByNotificationIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationIds');
    });
  }
}

extension ActiveNotificationsQueryProperty
    on QueryBuilder<ActiveNotifications, ActiveNotifications, QQueryProperty> {
  QueryBuilder<ActiveNotifications, int, QQueryOperations> taskidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskid');
    });
  }

  QueryBuilder<ActiveNotifications, List<String>, QQueryOperations>
      notificationIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationIds');
    });
  }
}
