// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $TripsTable extends Trips with drift.TableInfo<$TripsTable, Trip> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta = const drift.VerificationMeta(
    'id',
  );
  @override
  late final drift.GeneratedColumn<String> id = drift.GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _destinationMeta =
      const drift.VerificationMeta('destination');
  @override
  late final drift.GeneratedColumn<String> destination =
      drift.GeneratedColumn<String>(
        'destination',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _startDateMsMeta =
      const drift.VerificationMeta('startDateMs');
  @override
  late final drift.GeneratedColumn<int> startDateMs =
      drift.GeneratedColumn<int>(
        'start_date_ms',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _endDateMsMeta =
      const drift.VerificationMeta('endDateMs');
  @override
  late final drift.GeneratedColumn<int> endDateMs = drift.GeneratedColumn<int>(
    'end_date_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _transportModeMeta =
      const drift.VerificationMeta('transportMode');
  @override
  late final drift.GeneratedColumn<String> transportMode =
      drift.GeneratedColumn<String>(
        'transport_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant("plane"),
      );
  static const drift.VerificationMeta _accommodationMeta =
      const drift.VerificationMeta('accommodation');
  @override
  late final drift.GeneratedColumn<String> accommodation =
      drift.GeneratedColumn<String>(
        'accommodation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const drift.VerificationMeta _budgetPlannedMeta =
      const drift.VerificationMeta('budgetPlanned');
  @override
  late final drift.GeneratedColumn<double> budgetPlanned =
      drift.GeneratedColumn<double>(
        'budget_planned',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(0),
      );
  static const drift.VerificationMeta _budgetSpentMeta =
      const drift.VerificationMeta('budgetSpent');
  @override
  late final drift.GeneratedColumn<double> budgetSpent =
      drift.GeneratedColumn<double>(
        'budget_spent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(0),
      );
  static const drift.VerificationMeta _packingListMeta =
      const drift.VerificationMeta('packingList');
  @override
  late final drift.GeneratedColumn<String> packingList =
      drift.GeneratedColumn<String>(
        'packing_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(""),
      );
  static const drift.VerificationMeta _placesToVisitMeta =
      const drift.VerificationMeta('placesToVisit');
  @override
  late final drift.GeneratedColumn<String> placesToVisit =
      drift.GeneratedColumn<String>(
        'places_to_visit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(""),
      );
  static const drift.VerificationMeta _placesToEatMeta =
      const drift.VerificationMeta('placesToEat');
  @override
  late final drift.GeneratedColumn<String> placesToEat =
      drift.GeneratedColumn<String>(
        'places_to_eat',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(""),
      );
  static const drift.VerificationMeta _notesMeta = const drift.VerificationMeta(
    'notes',
  );
  @override
  late final drift.GeneratedColumn<String> notes =
      drift.GeneratedColumn<String>(
        'notes_text',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(""),
      );
  static const drift.VerificationMeta _statusMeta =
      const drift.VerificationMeta('status');
  @override
  late final drift.GeneratedColumn<String> status =
      drift.GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant("planned"),
      );
  static const drift.VerificationMeta _createdAtMsMeta =
      const drift.VerificationMeta('createdAtMs');
  @override
  late final drift.GeneratedColumn<int> createdAtMs =
      drift.GeneratedColumn<int>(
        'created_at_ms',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _updatedAtMsMeta =
      const drift.VerificationMeta('updatedAtMs');
  @override
  late final drift.GeneratedColumn<int> updatedAtMs =
      drift.GeneratedColumn<int>(
        'updated_at_ms',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _pendingSyncMeta =
      const drift.VerificationMeta('pendingSync');
  @override
  late final drift.GeneratedColumn<bool> pendingSync =
      drift.GeneratedColumn<bool>(
        'pending_sync',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))',
        ),
        defaultValue: const drift.Constant(false),
      );
  @override
  List<drift.GeneratedColumn> get $columns => [
    id,
    destination,
    startDateMs,
    endDateMs,
    transportMode,
    accommodation,
    budgetPlanned,
    budgetSpent,
    packingList,
    placesToVisit,
    placesToEat,
    notes,
    status,
    createdAtMs,
    updatedAtMs,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  drift.VerificationContext validateIntegrity(
    drift.Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
        _destinationMeta,
        destination.isAcceptableOrUnknown(
          data['destination']!,
          _destinationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('start_date_ms')) {
      context.handle(
        _startDateMsMeta,
        startDateMs.isAcceptableOrUnknown(
          data['start_date_ms']!,
          _startDateMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startDateMsMeta);
    }
    if (data.containsKey('end_date_ms')) {
      context.handle(
        _endDateMsMeta,
        endDateMs.isAcceptableOrUnknown(data['end_date_ms']!, _endDateMsMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMsMeta);
    }
    if (data.containsKey('transport_mode')) {
      context.handle(
        _transportModeMeta,
        transportMode.isAcceptableOrUnknown(
          data['transport_mode']!,
          _transportModeMeta,
        ),
      );
    }
    if (data.containsKey('accommodation')) {
      context.handle(
        _accommodationMeta,
        accommodation.isAcceptableOrUnknown(
          data['accommodation']!,
          _accommodationMeta,
        ),
      );
    }
    if (data.containsKey('budget_planned')) {
      context.handle(
        _budgetPlannedMeta,
        budgetPlanned.isAcceptableOrUnknown(
          data['budget_planned']!,
          _budgetPlannedMeta,
        ),
      );
    }
    if (data.containsKey('budget_spent')) {
      context.handle(
        _budgetSpentMeta,
        budgetSpent.isAcceptableOrUnknown(
          data['budget_spent']!,
          _budgetSpentMeta,
        ),
      );
    }
    if (data.containsKey('packing_list')) {
      context.handle(
        _packingListMeta,
        packingList.isAcceptableOrUnknown(
          data['packing_list']!,
          _packingListMeta,
        ),
      );
    }
    if (data.containsKey('places_to_visit')) {
      context.handle(
        _placesToVisitMeta,
        placesToVisit.isAcceptableOrUnknown(
          data['places_to_visit']!,
          _placesToVisitMeta,
        ),
      );
    }
    if (data.containsKey('places_to_eat')) {
      context.handle(
        _placesToEatMeta,
        placesToEat.isAcceptableOrUnknown(
          data['places_to_eat']!,
          _placesToEatMeta,
        ),
      );
    }
    if (data.containsKey('notes_text')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes_text']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      destination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination'],
      )!,
      startDateMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_date_ms'],
      )!,
      endDateMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_date_ms'],
      )!,
      transportMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transport_mode'],
      )!,
      accommodation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accommodation'],
      ),
      budgetPlanned: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}budget_planned'],
      )!,
      budgetSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}budget_spent'],
      )!,
      packingList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}packing_list'],
      )!,
      placesToVisit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}places_to_visit'],
      )!,
      placesToEat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}places_to_eat'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_text'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends drift.DataClass implements drift.Insertable<Trip> {
  final String id;
  final String destination;
  final int startDateMs;
  final int endDateMs;
  final String transportMode;
  final String? accommodation;
  final double budgetPlanned;
  final double budgetSpent;
  final String packingList;
  final String placesToVisit;
  final String placesToEat;
  final String notes;
  final String status;
  final int createdAtMs;
  final int updatedAtMs;
  final bool pendingSync;
  const Trip({
    required this.id,
    required this.destination,
    required this.startDateMs,
    required this.endDateMs,
    required this.transportMode,
    this.accommodation,
    required this.budgetPlanned,
    required this.budgetSpent,
    required this.packingList,
    required this.placesToVisit,
    required this.placesToEat,
    required this.notes,
    required this.status,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.pendingSync,
  });
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<String>(id);
    map['destination'] = drift.Variable<String>(destination);
    map['start_date_ms'] = drift.Variable<int>(startDateMs);
    map['end_date_ms'] = drift.Variable<int>(endDateMs);
    map['transport_mode'] = drift.Variable<String>(transportMode);
    if (!nullToAbsent || accommodation != null) {
      map['accommodation'] = drift.Variable<String>(accommodation);
    }
    map['budget_planned'] = drift.Variable<double>(budgetPlanned);
    map['budget_spent'] = drift.Variable<double>(budgetSpent);
    map['packing_list'] = drift.Variable<String>(packingList);
    map['places_to_visit'] = drift.Variable<String>(placesToVisit);
    map['places_to_eat'] = drift.Variable<String>(placesToEat);
    map['notes_text'] = drift.Variable<String>(notes);
    map['status'] = drift.Variable<String>(status);
    map['created_at_ms'] = drift.Variable<int>(createdAtMs);
    map['updated_at_ms'] = drift.Variable<int>(updatedAtMs);
    map['pending_sync'] = drift.Variable<bool>(pendingSync);
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: drift.Value(id),
      destination: drift.Value(destination),
      startDateMs: drift.Value(startDateMs),
      endDateMs: drift.Value(endDateMs),
      transportMode: drift.Value(transportMode),
      accommodation: accommodation == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(accommodation),
      budgetPlanned: drift.Value(budgetPlanned),
      budgetSpent: drift.Value(budgetSpent),
      packingList: drift.Value(packingList),
      placesToVisit: drift.Value(placesToVisit),
      placesToEat: drift.Value(placesToEat),
      notes: drift.Value(notes),
      status: drift.Value(status),
      createdAtMs: drift.Value(createdAtMs),
      updatedAtMs: drift.Value(updatedAtMs),
      pendingSync: drift.Value(pendingSync),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<String>(json['id']),
      destination: serializer.fromJson<String>(json['destination']),
      startDateMs: serializer.fromJson<int>(json['startDateMs']),
      endDateMs: serializer.fromJson<int>(json['endDateMs']),
      transportMode: serializer.fromJson<String>(json['transportMode']),
      accommodation: serializer.fromJson<String?>(json['accommodation']),
      budgetPlanned: serializer.fromJson<double>(json['budgetPlanned']),
      budgetSpent: serializer.fromJson<double>(json['budgetSpent']),
      packingList: serializer.fromJson<String>(json['packingList']),
      placesToVisit: serializer.fromJson<String>(json['placesToVisit']),
      placesToEat: serializer.fromJson<String>(json['placesToEat']),
      notes: serializer.fromJson<String>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'destination': serializer.toJson<String>(destination),
      'startDateMs': serializer.toJson<int>(startDateMs),
      'endDateMs': serializer.toJson<int>(endDateMs),
      'transportMode': serializer.toJson<String>(transportMode),
      'accommodation': serializer.toJson<String?>(accommodation),
      'budgetPlanned': serializer.toJson<double>(budgetPlanned),
      'budgetSpent': serializer.toJson<double>(budgetSpent),
      'packingList': serializer.toJson<String>(packingList),
      'placesToVisit': serializer.toJson<String>(placesToVisit),
      'placesToEat': serializer.toJson<String>(placesToEat),
      'notes': serializer.toJson<String>(notes),
      'status': serializer.toJson<String>(status),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  Trip copyWith({
    String? id,
    String? destination,
    int? startDateMs,
    int? endDateMs,
    String? transportMode,
    drift.Value<String?> accommodation = const drift.Value.absent(),
    double? budgetPlanned,
    double? budgetSpent,
    String? packingList,
    String? placesToVisit,
    String? placesToEat,
    String? notes,
    String? status,
    int? createdAtMs,
    int? updatedAtMs,
    bool? pendingSync,
  }) => Trip(
    id: id ?? this.id,
    destination: destination ?? this.destination,
    startDateMs: startDateMs ?? this.startDateMs,
    endDateMs: endDateMs ?? this.endDateMs,
    transportMode: transportMode ?? this.transportMode,
    accommodation: accommodation.present
        ? accommodation.value
        : this.accommodation,
    budgetPlanned: budgetPlanned ?? this.budgetPlanned,
    budgetSpent: budgetSpent ?? this.budgetSpent,
    packingList: packingList ?? this.packingList,
    placesToVisit: placesToVisit ?? this.placesToVisit,
    placesToEat: placesToEat ?? this.placesToEat,
    notes: notes ?? this.notes,
    status: status ?? this.status,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      destination: data.destination.present
          ? data.destination.value
          : this.destination,
      startDateMs: data.startDateMs.present
          ? data.startDateMs.value
          : this.startDateMs,
      endDateMs: data.endDateMs.present ? data.endDateMs.value : this.endDateMs,
      transportMode: data.transportMode.present
          ? data.transportMode.value
          : this.transportMode,
      accommodation: data.accommodation.present
          ? data.accommodation.value
          : this.accommodation,
      budgetPlanned: data.budgetPlanned.present
          ? data.budgetPlanned.value
          : this.budgetPlanned,
      budgetSpent: data.budgetSpent.present
          ? data.budgetSpent.value
          : this.budgetSpent,
      packingList: data.packingList.present
          ? data.packingList.value
          : this.packingList,
      placesToVisit: data.placesToVisit.present
          ? data.placesToVisit.value
          : this.placesToVisit,
      placesToEat: data.placesToEat.present
          ? data.placesToEat.value
          : this.placesToEat,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('destination: $destination, ')
          ..write('startDateMs: $startDateMs, ')
          ..write('endDateMs: $endDateMs, ')
          ..write('transportMode: $transportMode, ')
          ..write('accommodation: $accommodation, ')
          ..write('budgetPlanned: $budgetPlanned, ')
          ..write('budgetSpent: $budgetSpent, ')
          ..write('packingList: $packingList, ')
          ..write('placesToVisit: $placesToVisit, ')
          ..write('placesToEat: $placesToEat, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    destination,
    startDateMs,
    endDateMs,
    transportMode,
    accommodation,
    budgetPlanned,
    budgetSpent,
    packingList,
    placesToVisit,
    placesToEat,
    notes,
    status,
    createdAtMs,
    updatedAtMs,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.destination == this.destination &&
          other.startDateMs == this.startDateMs &&
          other.endDateMs == this.endDateMs &&
          other.transportMode == this.transportMode &&
          other.accommodation == this.accommodation &&
          other.budgetPlanned == this.budgetPlanned &&
          other.budgetSpent == this.budgetSpent &&
          other.packingList == this.packingList &&
          other.placesToVisit == this.placesToVisit &&
          other.placesToEat == this.placesToEat &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.pendingSync == this.pendingSync);
}

class TripsCompanion extends drift.UpdateCompanion<Trip> {
  final drift.Value<String> id;
  final drift.Value<String> destination;
  final drift.Value<int> startDateMs;
  final drift.Value<int> endDateMs;
  final drift.Value<String> transportMode;
  final drift.Value<String?> accommodation;
  final drift.Value<double> budgetPlanned;
  final drift.Value<double> budgetSpent;
  final drift.Value<String> packingList;
  final drift.Value<String> placesToVisit;
  final drift.Value<String> placesToEat;
  final drift.Value<String> notes;
  final drift.Value<String> status;
  final drift.Value<int> createdAtMs;
  final drift.Value<int> updatedAtMs;
  final drift.Value<bool> pendingSync;
  final drift.Value<int> rowid;
  const TripsCompanion({
    this.id = const drift.Value.absent(),
    this.destination = const drift.Value.absent(),
    this.startDateMs = const drift.Value.absent(),
    this.endDateMs = const drift.Value.absent(),
    this.transportMode = const drift.Value.absent(),
    this.accommodation = const drift.Value.absent(),
    this.budgetPlanned = const drift.Value.absent(),
    this.budgetSpent = const drift.Value.absent(),
    this.packingList = const drift.Value.absent(),
    this.placesToVisit = const drift.Value.absent(),
    this.placesToEat = const drift.Value.absent(),
    this.notes = const drift.Value.absent(),
    this.status = const drift.Value.absent(),
    this.createdAtMs = const drift.Value.absent(),
    this.updatedAtMs = const drift.Value.absent(),
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  });
  TripsCompanion.insert({
    required String id,
    required String destination,
    required int startDateMs,
    required int endDateMs,
    this.transportMode = const drift.Value.absent(),
    this.accommodation = const drift.Value.absent(),
    this.budgetPlanned = const drift.Value.absent(),
    this.budgetSpent = const drift.Value.absent(),
    this.packingList = const drift.Value.absent(),
    this.placesToVisit = const drift.Value.absent(),
    this.placesToEat = const drift.Value.absent(),
    this.notes = const drift.Value.absent(),
    this.status = const drift.Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  }) : id = drift.Value(id),
       destination = drift.Value(destination),
       startDateMs = drift.Value(startDateMs),
       endDateMs = drift.Value(endDateMs),
       createdAtMs = drift.Value(createdAtMs),
       updatedAtMs = drift.Value(updatedAtMs);
  static drift.Insertable<Trip> custom({
    drift.Expression<String>? id,
    drift.Expression<String>? destination,
    drift.Expression<int>? startDateMs,
    drift.Expression<int>? endDateMs,
    drift.Expression<String>? transportMode,
    drift.Expression<String>? accommodation,
    drift.Expression<double>? budgetPlanned,
    drift.Expression<double>? budgetSpent,
    drift.Expression<String>? packingList,
    drift.Expression<String>? placesToVisit,
    drift.Expression<String>? placesToEat,
    drift.Expression<String>? notes,
    drift.Expression<String>? status,
    drift.Expression<int>? createdAtMs,
    drift.Expression<int>? updatedAtMs,
    drift.Expression<bool>? pendingSync,
    drift.Expression<int>? rowid,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (destination != null) 'destination': destination,
      if (startDateMs != null) 'start_date_ms': startDateMs,
      if (endDateMs != null) 'end_date_ms': endDateMs,
      if (transportMode != null) 'transport_mode': transportMode,
      if (accommodation != null) 'accommodation': accommodation,
      if (budgetPlanned != null) 'budget_planned': budgetPlanned,
      if (budgetSpent != null) 'budget_spent': budgetSpent,
      if (packingList != null) 'packing_list': packingList,
      if (placesToVisit != null) 'places_to_visit': placesToVisit,
      if (placesToEat != null) 'places_to_eat': placesToEat,
      if (notes != null) 'notes_text': notes,
      if (status != null) 'status': status,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripsCompanion copyWith({
    drift.Value<String>? id,
    drift.Value<String>? destination,
    drift.Value<int>? startDateMs,
    drift.Value<int>? endDateMs,
    drift.Value<String>? transportMode,
    drift.Value<String?>? accommodation,
    drift.Value<double>? budgetPlanned,
    drift.Value<double>? budgetSpent,
    drift.Value<String>? packingList,
    drift.Value<String>? placesToVisit,
    drift.Value<String>? placesToEat,
    drift.Value<String>? notes,
    drift.Value<String>? status,
    drift.Value<int>? createdAtMs,
    drift.Value<int>? updatedAtMs,
    drift.Value<bool>? pendingSync,
    drift.Value<int>? rowid,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      startDateMs: startDateMs ?? this.startDateMs,
      endDateMs: endDateMs ?? this.endDateMs,
      transportMode: transportMode ?? this.transportMode,
      accommodation: accommodation ?? this.accommodation,
      budgetPlanned: budgetPlanned ?? this.budgetPlanned,
      budgetSpent: budgetSpent ?? this.budgetSpent,
      packingList: packingList ?? this.packingList,
      placesToVisit: placesToVisit ?? this.placesToVisit,
      placesToEat: placesToEat ?? this.placesToEat,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<String>(id.value);
    }
    if (destination.present) {
      map['destination'] = drift.Variable<String>(destination.value);
    }
    if (startDateMs.present) {
      map['start_date_ms'] = drift.Variable<int>(startDateMs.value);
    }
    if (endDateMs.present) {
      map['end_date_ms'] = drift.Variable<int>(endDateMs.value);
    }
    if (transportMode.present) {
      map['transport_mode'] = drift.Variable<String>(transportMode.value);
    }
    if (accommodation.present) {
      map['accommodation'] = drift.Variable<String>(accommodation.value);
    }
    if (budgetPlanned.present) {
      map['budget_planned'] = drift.Variable<double>(budgetPlanned.value);
    }
    if (budgetSpent.present) {
      map['budget_spent'] = drift.Variable<double>(budgetSpent.value);
    }
    if (packingList.present) {
      map['packing_list'] = drift.Variable<String>(packingList.value);
    }
    if (placesToVisit.present) {
      map['places_to_visit'] = drift.Variable<String>(placesToVisit.value);
    }
    if (placesToEat.present) {
      map['places_to_eat'] = drift.Variable<String>(placesToEat.value);
    }
    if (notes.present) {
      map['notes_text'] = drift.Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = drift.Variable<String>(status.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = drift.Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = drift.Variable<int>(updatedAtMs.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = drift.Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = drift.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('destination: $destination, ')
          ..write('startDateMs: $startDateMs, ')
          ..write('endDateMs: $endDateMs, ')
          ..write('transportMode: $transportMode, ')
          ..write('accommodation: $accommodation, ')
          ..write('budgetPlanned: $budgetPlanned, ')
          ..write('budgetSpent: $budgetSpent, ')
          ..write('packingList: $packingList, ')
          ..write('placesToVisit: $placesToVisit, ')
          ..write('placesToEat: $placesToEat, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistItemsTable extends ChecklistItems
    with drift.TableInfo<$ChecklistItemsTable, ChecklistItem> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistItemsTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta = const drift.VerificationMeta(
    'id',
  );
  @override
  late final drift.GeneratedColumn<String> id = drift.GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _tripIdMeta =
      const drift.VerificationMeta('tripId');
  @override
  late final drift.GeneratedColumn<String> tripId =
      drift.GeneratedColumn<String>(
        'trip_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _textValueMeta =
      const drift.VerificationMeta('textValue');
  @override
  late final drift.GeneratedColumn<String> textValue =
      drift.GeneratedColumn<String>(
        'text_value',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _doneMeta = const drift.VerificationMeta(
    'done',
  );
  @override
  late final drift.GeneratedColumn<bool> done = drift.GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: const drift.Constant(false),
  );
  static const drift.VerificationMeta _orderIndexMeta =
      const drift.VerificationMeta('orderIndex');
  @override
  late final drift.GeneratedColumn<int> orderIndex = drift.GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const drift.Constant(0),
  );
  static const drift.VerificationMeta _createdAtMsMeta =
      const drift.VerificationMeta('createdAtMs');
  @override
  late final drift.GeneratedColumn<int> createdAtMs =
      drift.GeneratedColumn<int>(
        'created_at_ms',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _pendingSyncMeta =
      const drift.VerificationMeta('pendingSync');
  @override
  late final drift.GeneratedColumn<bool> pendingSync =
      drift.GeneratedColumn<bool>(
        'pending_sync',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))',
        ),
        defaultValue: const drift.Constant(false),
      );
  @override
  List<drift.GeneratedColumn> get $columns => [
    id,
    tripId,
    textValue,
    done,
    orderIndex,
    createdAtMs,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_items';
  @override
  drift.VerificationContext validateIntegrity(
    drift.Insertable<ChecklistItem> instance, {
    bool isInserting = false,
  }) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('text_value')) {
      context.handle(
        _textValueMeta,
        textValue.isAcceptableOrUnknown(data['text_value']!, _textValueMeta),
      );
    } else if (isInserting) {
      context.missing(_textValueMeta);
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      textValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_value'],
      )!,
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $ChecklistItemsTable createAlias(String alias) {
    return $ChecklistItemsTable(attachedDatabase, alias);
  }
}

class ChecklistItem extends drift.DataClass
    implements drift.Insertable<ChecklistItem> {
  final String id;
  final String tripId;
  final String textValue;
  final bool done;
  final int orderIndex;
  final int createdAtMs;
  final bool pendingSync;
  const ChecklistItem({
    required this.id,
    required this.tripId,
    required this.textValue,
    required this.done,
    required this.orderIndex,
    required this.createdAtMs,
    required this.pendingSync,
  });
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<String>(id);
    map['trip_id'] = drift.Variable<String>(tripId);
    map['text_value'] = drift.Variable<String>(textValue);
    map['done'] = drift.Variable<bool>(done);
    map['order_index'] = drift.Variable<int>(orderIndex);
    map['created_at_ms'] = drift.Variable<int>(createdAtMs);
    map['pending_sync'] = drift.Variable<bool>(pendingSync);
    return map;
  }

  ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistItemsCompanion(
      id: drift.Value(id),
      tripId: drift.Value(tripId),
      textValue: drift.Value(textValue),
      done: drift.Value(done),
      orderIndex: drift.Value(orderIndex),
      createdAtMs: drift.Value(createdAtMs),
      pendingSync: drift.Value(pendingSync),
    );
  }

  factory ChecklistItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return ChecklistItem(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      textValue: serializer.fromJson<String>(json['textValue']),
      done: serializer.fromJson<bool>(json['done']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'textValue': serializer.toJson<String>(textValue),
      'done': serializer.toJson<bool>(done),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  ChecklistItem copyWith({
    String? id,
    String? tripId,
    String? textValue,
    bool? done,
    int? orderIndex,
    int? createdAtMs,
    bool? pendingSync,
  }) => ChecklistItem(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    textValue: textValue ?? this.textValue,
    done: done ?? this.done,
    orderIndex: orderIndex ?? this.orderIndex,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  ChecklistItem copyWithCompanion(ChecklistItemsCompanion data) {
    return ChecklistItem(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      textValue: data.textValue.present ? data.textValue.value : this.textValue,
      done: data.done.present ? data.done.value : this.done,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItem(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('textValue: $textValue, ')
          ..write('done: $done, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    textValue,
    done,
    orderIndex,
    createdAtMs,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistItem &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.textValue == this.textValue &&
          other.done == this.done &&
          other.orderIndex == this.orderIndex &&
          other.createdAtMs == this.createdAtMs &&
          other.pendingSync == this.pendingSync);
}

class ChecklistItemsCompanion extends drift.UpdateCompanion<ChecklistItem> {
  final drift.Value<String> id;
  final drift.Value<String> tripId;
  final drift.Value<String> textValue;
  final drift.Value<bool> done;
  final drift.Value<int> orderIndex;
  final drift.Value<int> createdAtMs;
  final drift.Value<bool> pendingSync;
  final drift.Value<int> rowid;
  const ChecklistItemsCompanion({
    this.id = const drift.Value.absent(),
    this.tripId = const drift.Value.absent(),
    this.textValue = const drift.Value.absent(),
    this.done = const drift.Value.absent(),
    this.orderIndex = const drift.Value.absent(),
    this.createdAtMs = const drift.Value.absent(),
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  });
  ChecklistItemsCompanion.insert({
    required String id,
    required String tripId,
    required String textValue,
    this.done = const drift.Value.absent(),
    this.orderIndex = const drift.Value.absent(),
    required int createdAtMs,
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  }) : id = drift.Value(id),
       tripId = drift.Value(tripId),
       textValue = drift.Value(textValue),
       createdAtMs = drift.Value(createdAtMs);
  static drift.Insertable<ChecklistItem> custom({
    drift.Expression<String>? id,
    drift.Expression<String>? tripId,
    drift.Expression<String>? textValue,
    drift.Expression<bool>? done,
    drift.Expression<int>? orderIndex,
    drift.Expression<int>? createdAtMs,
    drift.Expression<bool>? pendingSync,
    drift.Expression<int>? rowid,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (textValue != null) 'text_value': textValue,
      if (done != null) 'done': done,
      if (orderIndex != null) 'order_index': orderIndex,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistItemsCompanion copyWith({
    drift.Value<String>? id,
    drift.Value<String>? tripId,
    drift.Value<String>? textValue,
    drift.Value<bool>? done,
    drift.Value<int>? orderIndex,
    drift.Value<int>? createdAtMs,
    drift.Value<bool>? pendingSync,
    drift.Value<int>? rowid,
  }) {
    return ChecklistItemsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      textValue: textValue ?? this.textValue,
      done: done ?? this.done,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = drift.Variable<String>(tripId.value);
    }
    if (textValue.present) {
      map['text_value'] = drift.Variable<String>(textValue.value);
    }
    if (done.present) {
      map['done'] = drift.Variable<bool>(done.value);
    }
    if (orderIndex.present) {
      map['order_index'] = drift.Variable<int>(orderIndex.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = drift.Variable<int>(createdAtMs.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = drift.Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = drift.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('textValue: $textValue, ')
          ..write('done: $done, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with drift.TableInfo<$ExpensesTable, Expense> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta = const drift.VerificationMeta(
    'id',
  );
  @override
  late final drift.GeneratedColumn<String> id = drift.GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _tripIdMeta =
      const drift.VerificationMeta('tripId');
  @override
  late final drift.GeneratedColumn<String> tripId =
      drift.GeneratedColumn<String>(
        'trip_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _categoryMeta =
      const drift.VerificationMeta('category');
  @override
  late final drift.GeneratedColumn<String> category =
      drift.GeneratedColumn<String>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _amountMeta =
      const drift.VerificationMeta('amount');
  @override
  late final drift.GeneratedColumn<double> amount =
      drift.GeneratedColumn<double>(
        'amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _currencyMeta =
      const drift.VerificationMeta('currency');
  @override
  late final drift.GeneratedColumn<String> currency =
      drift.GeneratedColumn<String>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant("RON"),
      );
  static const drift.VerificationMeta _dateMsMeta =
      const drift.VerificationMeta('dateMs');
  @override
  late final drift.GeneratedColumn<int> dateMs = drift.GeneratedColumn<int>(
    'date_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _descriptionMeta =
      const drift.VerificationMeta('description');
  @override
  late final drift.GeneratedColumn<String> description =
      drift.GeneratedColumn<String>(
        'description',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const drift.Constant(""),
      );
  static const drift.VerificationMeta _pendingSyncMeta =
      const drift.VerificationMeta('pendingSync');
  @override
  late final drift.GeneratedColumn<bool> pendingSync =
      drift.GeneratedColumn<bool>(
        'pending_sync',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))',
        ),
        defaultValue: const drift.Constant(false),
      );
  @override
  List<drift.GeneratedColumn> get $columns => [
    id,
    tripId,
    category,
    amount,
    currency,
    dateMs,
    description,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  drift.VerificationContext validateIntegrity(
    drift.Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('date_ms')) {
      context.handle(
        _dateMsMeta,
        dateMs.isAcceptableOrUnknown(data['date_ms']!, _dateMsMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      dateMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_ms'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends drift.DataClass implements drift.Insertable<Expense> {
  final String id;
  final String tripId;
  final String category;
  final double amount;
  final String currency;
  final int dateMs;
  final String description;
  final bool pendingSync;
  const Expense({
    required this.id,
    required this.tripId,
    required this.category,
    required this.amount,
    required this.currency,
    required this.dateMs,
    required this.description,
    required this.pendingSync,
  });
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<String>(id);
    map['trip_id'] = drift.Variable<String>(tripId);
    map['category'] = drift.Variable<String>(category);
    map['amount'] = drift.Variable<double>(amount);
    map['currency'] = drift.Variable<String>(currency);
    map['date_ms'] = drift.Variable<int>(dateMs);
    map['description'] = drift.Variable<String>(description);
    map['pending_sync'] = drift.Variable<bool>(pendingSync);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: drift.Value(id),
      tripId: drift.Value(tripId),
      category: drift.Value(category),
      amount: drift.Value(amount),
      currency: drift.Value(currency),
      dateMs: drift.Value(dateMs),
      description: drift.Value(description),
      pendingSync: drift.Value(pendingSync),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      dateMs: serializer.fromJson<int>(json['dateMs']),
      description: serializer.fromJson<String>(json['description']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'dateMs': serializer.toJson<int>(dateMs),
      'description': serializer.toJson<String>(description),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  Expense copyWith({
    String? id,
    String? tripId,
    String? category,
    double? amount,
    String? currency,
    int? dateMs,
    String? description,
    bool? pendingSync,
  }) => Expense(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    dateMs: dateMs ?? this.dateMs,
    description: description ?? this.description,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      dateMs: data.dateMs.present ? data.dateMs.value : this.dateMs,
      description: data.description.present
          ? data.description.value
          : this.description,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('dateMs: $dateMs, ')
          ..write('description: $description, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    category,
    amount,
    currency,
    dateMs,
    description,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.dateMs == this.dateMs &&
          other.description == this.description &&
          other.pendingSync == this.pendingSync);
}

class ExpensesCompanion extends drift.UpdateCompanion<Expense> {
  final drift.Value<String> id;
  final drift.Value<String> tripId;
  final drift.Value<String> category;
  final drift.Value<double> amount;
  final drift.Value<String> currency;
  final drift.Value<int> dateMs;
  final drift.Value<String> description;
  final drift.Value<bool> pendingSync;
  final drift.Value<int> rowid;
  const ExpensesCompanion({
    this.id = const drift.Value.absent(),
    this.tripId = const drift.Value.absent(),
    this.category = const drift.Value.absent(),
    this.amount = const drift.Value.absent(),
    this.currency = const drift.Value.absent(),
    this.dateMs = const drift.Value.absent(),
    this.description = const drift.Value.absent(),
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String tripId,
    required String category,
    required double amount,
    this.currency = const drift.Value.absent(),
    required int dateMs,
    this.description = const drift.Value.absent(),
    this.pendingSync = const drift.Value.absent(),
    this.rowid = const drift.Value.absent(),
  }) : id = drift.Value(id),
       tripId = drift.Value(tripId),
       category = drift.Value(category),
       amount = drift.Value(amount),
       dateMs = drift.Value(dateMs);
  static drift.Insertable<Expense> custom({
    drift.Expression<String>? id,
    drift.Expression<String>? tripId,
    drift.Expression<String>? category,
    drift.Expression<double>? amount,
    drift.Expression<String>? currency,
    drift.Expression<int>? dateMs,
    drift.Expression<String>? description,
    drift.Expression<bool>? pendingSync,
    drift.Expression<int>? rowid,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (dateMs != null) 'date_ms': dateMs,
      if (description != null) 'description': description,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    drift.Value<String>? id,
    drift.Value<String>? tripId,
    drift.Value<String>? category,
    drift.Value<double>? amount,
    drift.Value<String>? currency,
    drift.Value<int>? dateMs,
    drift.Value<String>? description,
    drift.Value<bool>? pendingSync,
    drift.Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      dateMs: dateMs ?? this.dateMs,
      description: description ?? this.description,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = drift.Variable<String>(tripId.value);
    }
    if (category.present) {
      map['category'] = drift.Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = drift.Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = drift.Variable<String>(currency.value);
    }
    if (dateMs.present) {
      map['date_ms'] = drift.Variable<int>(dateMs.value);
    }
    if (description.present) {
      map['description'] = drift.Variable<String>(description.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = drift.Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = drift.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('dateMs: $dateMs, ')
          ..write('description: $description, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends drift.GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final TripsDao tripsDao = TripsDao(this as AppDb);
  late final ChecklistDao checklistDao = ChecklistDao(this as AppDb);
  late final ExpensesDao expensesDao = ExpensesDao(this as AppDb);
  @override
  Iterable<drift.TableInfo<drift.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<drift.TableInfo<drift.Table, Object?>>();
  @override
  List<drift.DatabaseSchemaEntity> get allSchemaEntities => [
    trips,
    checklistItems,
    expenses,
  ];
}

typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      required String id,
      required String destination,
      required int startDateMs,
      required int endDateMs,
      drift.Value<String> transportMode,
      drift.Value<String?> accommodation,
      drift.Value<double> budgetPlanned,
      drift.Value<double> budgetSpent,
      drift.Value<String> packingList,
      drift.Value<String> placesToVisit,
      drift.Value<String> placesToEat,
      drift.Value<String> notes,
      drift.Value<String> status,
      required int createdAtMs,
      required int updatedAtMs,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      drift.Value<String> id,
      drift.Value<String> destination,
      drift.Value<int> startDateMs,
      drift.Value<int> endDateMs,
      drift.Value<String> transportMode,
      drift.Value<String?> accommodation,
      drift.Value<double> budgetPlanned,
      drift.Value<double> budgetSpent,
      drift.Value<String> packingList,
      drift.Value<String> placesToVisit,
      drift.Value<String> placesToEat,
      drift.Value<String> notes,
      drift.Value<String> status,
      drift.Value<int> createdAtMs,
      drift.Value<int> updatedAtMs,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });

class $$TripsTableFilterComposer extends drift.Composer<_$AppDb, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get startDateMs => $composableBuilder(
    column: $table.startDateMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get endDateMs => $composableBuilder(
    column: $table.endDateMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get transportMode => $composableBuilder(
    column: $table.transportMode,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get accommodation => $composableBuilder(
    column: $table.accommodation,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<double> get budgetPlanned => $composableBuilder(
    column: $table.budgetPlanned,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<double> get budgetSpent => $composableBuilder(
    column: $table.budgetSpent,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get packingList => $composableBuilder(
    column: $table.packingList,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get placesToVisit => $composableBuilder(
    column: $table.placesToVisit,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get placesToEat => $composableBuilder(
    column: $table.placesToEat,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnFilters(column),
  );
}

class $$TripsTableOrderingComposer
    extends drift.Composer<_$AppDb, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get startDateMs => $composableBuilder(
    column: $table.startDateMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get endDateMs => $composableBuilder(
    column: $table.endDateMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get transportMode => $composableBuilder(
    column: $table.transportMode,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get accommodation => $composableBuilder(
    column: $table.accommodation,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<double> get budgetPlanned => $composableBuilder(
    column: $table.budgetPlanned,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<double> get budgetSpent => $composableBuilder(
    column: $table.budgetSpent,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get packingList => $composableBuilder(
    column: $table.packingList,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get placesToVisit => $composableBuilder(
    column: $table.placesToVisit,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get placesToEat => $composableBuilder(
    column: $table.placesToEat,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnOrderings(column),
  );
}

class $$TripsTableAnnotationComposer
    extends drift.Composer<_$AppDb, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => column,
  );

  drift.GeneratedColumn<int> get startDateMs => $composableBuilder(
    column: $table.startDateMs,
    builder: (column) => column,
  );

  drift.GeneratedColumn<int> get endDateMs =>
      $composableBuilder(column: $table.endDateMs, builder: (column) => column);

  drift.GeneratedColumn<String> get transportMode => $composableBuilder(
    column: $table.transportMode,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get accommodation => $composableBuilder(
    column: $table.accommodation,
    builder: (column) => column,
  );

  drift.GeneratedColumn<double> get budgetPlanned => $composableBuilder(
    column: $table.budgetPlanned,
    builder: (column) => column,
  );

  drift.GeneratedColumn<double> get budgetSpent => $composableBuilder(
    column: $table.budgetSpent,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get packingList => $composableBuilder(
    column: $table.packingList,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get placesToVisit => $composableBuilder(
    column: $table.placesToVisit,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get placesToEat => $composableBuilder(
    column: $table.placesToEat,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  drift.GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  drift.GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  drift.GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  drift.GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$TripsTableTableManager
    extends
        drift.RootTableManager<
          _$AppDb,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, drift.BaseReferences<_$AppDb, $TripsTable, Trip>),
          Trip,
          drift.PrefetchHooks Function()
        > {
  $$TripsTableTableManager(_$AppDb db, $TripsTable table)
    : super(
        drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                drift.Value<String> id = const drift.Value.absent(),
                drift.Value<String> destination = const drift.Value.absent(),
                drift.Value<int> startDateMs = const drift.Value.absent(),
                drift.Value<int> endDateMs = const drift.Value.absent(),
                drift.Value<String> transportMode = const drift.Value.absent(),
                drift.Value<String?> accommodation = const drift.Value.absent(),
                drift.Value<double> budgetPlanned = const drift.Value.absent(),
                drift.Value<double> budgetSpent = const drift.Value.absent(),
                drift.Value<String> packingList = const drift.Value.absent(),
                drift.Value<String> placesToVisit = const drift.Value.absent(),
                drift.Value<String> placesToEat = const drift.Value.absent(),
                drift.Value<String> notes = const drift.Value.absent(),
                drift.Value<String> status = const drift.Value.absent(),
                drift.Value<int> createdAtMs = const drift.Value.absent(),
                drift.Value<int> updatedAtMs = const drift.Value.absent(),
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => TripsCompanion(
                id: id,
                destination: destination,
                startDateMs: startDateMs,
                endDateMs: endDateMs,
                transportMode: transportMode,
                accommodation: accommodation,
                budgetPlanned: budgetPlanned,
                budgetSpent: budgetSpent,
                packingList: packingList,
                placesToVisit: placesToVisit,
                placesToEat: placesToEat,
                notes: notes,
                status: status,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String destination,
                required int startDateMs,
                required int endDateMs,
                drift.Value<String> transportMode = const drift.Value.absent(),
                drift.Value<String?> accommodation = const drift.Value.absent(),
                drift.Value<double> budgetPlanned = const drift.Value.absent(),
                drift.Value<double> budgetSpent = const drift.Value.absent(),
                drift.Value<String> packingList = const drift.Value.absent(),
                drift.Value<String> placesToVisit = const drift.Value.absent(),
                drift.Value<String> placesToEat = const drift.Value.absent(),
                drift.Value<String> notes = const drift.Value.absent(),
                drift.Value<String> status = const drift.Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                destination: destination,
                startDateMs: startDateMs,
                endDateMs: endDateMs,
                transportMode: transportMode,
                accommodation: accommodation,
                budgetPlanned: budgetPlanned,
                budgetSpent: budgetSpent,
                packingList: packingList,
                placesToVisit: placesToVisit,
                placesToEat: placesToEat,
                notes: notes,
                status: status,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), drift.BaseReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    drift.ProcessedTableManager<
      _$AppDb,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, drift.BaseReferences<_$AppDb, $TripsTable, Trip>),
      Trip,
      drift.PrefetchHooks Function()
    >;
typedef $$ChecklistItemsTableCreateCompanionBuilder =
    ChecklistItemsCompanion Function({
      required String id,
      required String tripId,
      required String textValue,
      drift.Value<bool> done,
      drift.Value<int> orderIndex,
      required int createdAtMs,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });
typedef $$ChecklistItemsTableUpdateCompanionBuilder =
    ChecklistItemsCompanion Function({
      drift.Value<String> id,
      drift.Value<String> tripId,
      drift.Value<String> textValue,
      drift.Value<bool> done,
      drift.Value<int> orderIndex,
      drift.Value<int> createdAtMs,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });

class $$ChecklistItemsTableFilterComposer
    extends drift.Composer<_$AppDb, $ChecklistItemsTable> {
  $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get textValue => $composableBuilder(
    column: $table.textValue,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnFilters(column),
  );
}

class $$ChecklistItemsTableOrderingComposer
    extends drift.Composer<_$AppDb, $ChecklistItemsTable> {
  $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get textValue => $composableBuilder(
    column: $table.textValue,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnOrderings(column),
  );
}

class $$ChecklistItemsTableAnnotationComposer
    extends drift.Composer<_$AppDb, $ChecklistItemsTable> {
  $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  drift.GeneratedColumn<String> get textValue =>
      $composableBuilder(column: $table.textValue, builder: (column) => column);

  drift.GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  drift.GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  drift.GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  drift.GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$ChecklistItemsTableTableManager
    extends
        drift.RootTableManager<
          _$AppDb,
          $ChecklistItemsTable,
          ChecklistItem,
          $$ChecklistItemsTableFilterComposer,
          $$ChecklistItemsTableOrderingComposer,
          $$ChecklistItemsTableAnnotationComposer,
          $$ChecklistItemsTableCreateCompanionBuilder,
          $$ChecklistItemsTableUpdateCompanionBuilder,
          (
            ChecklistItem,
            drift.BaseReferences<_$AppDb, $ChecklistItemsTable, ChecklistItem>,
          ),
          ChecklistItem,
          drift.PrefetchHooks Function()
        > {
  $$ChecklistItemsTableTableManager(_$AppDb db, $ChecklistItemsTable table)
    : super(
        drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                drift.Value<String> id = const drift.Value.absent(),
                drift.Value<String> tripId = const drift.Value.absent(),
                drift.Value<String> textValue = const drift.Value.absent(),
                drift.Value<bool> done = const drift.Value.absent(),
                drift.Value<int> orderIndex = const drift.Value.absent(),
                drift.Value<int> createdAtMs = const drift.Value.absent(),
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => ChecklistItemsCompanion(
                id: id,
                tripId: tripId,
                textValue: textValue,
                done: done,
                orderIndex: orderIndex,
                createdAtMs: createdAtMs,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String textValue,
                drift.Value<bool> done = const drift.Value.absent(),
                drift.Value<int> orderIndex = const drift.Value.absent(),
                required int createdAtMs,
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => ChecklistItemsCompanion.insert(
                id: id,
                tripId: tripId,
                textValue: textValue,
                done: done,
                orderIndex: orderIndex,
                createdAtMs: createdAtMs,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), drift.BaseReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistItemsTableProcessedTableManager =
    drift.ProcessedTableManager<
      _$AppDb,
      $ChecklistItemsTable,
      ChecklistItem,
      $$ChecklistItemsTableFilterComposer,
      $$ChecklistItemsTableOrderingComposer,
      $$ChecklistItemsTableAnnotationComposer,
      $$ChecklistItemsTableCreateCompanionBuilder,
      $$ChecklistItemsTableUpdateCompanionBuilder,
      (
        ChecklistItem,
        drift.BaseReferences<_$AppDb, $ChecklistItemsTable, ChecklistItem>,
      ),
      ChecklistItem,
      drift.PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required String tripId,
      required String category,
      required double amount,
      drift.Value<String> currency,
      required int dateMs,
      drift.Value<String> description,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      drift.Value<String> id,
      drift.Value<String> tripId,
      drift.Value<String> category,
      drift.Value<double> amount,
      drift.Value<String> currency,
      drift.Value<int> dateMs,
      drift.Value<String> description,
      drift.Value<bool> pendingSync,
      drift.Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends drift.Composer<_$AppDb, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<int> get dateMs => $composableBuilder(
    column: $table.dateMs,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends drift.Composer<_$AppDb, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<int> get dateMs => $composableBuilder(
    column: $table.dateMs,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => drift.ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends drift.Composer<_$AppDb, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  drift.GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  drift.GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  drift.GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  drift.GeneratedColumn<int> get dateMs =>
      $composableBuilder(column: $table.dateMs, builder: (column) => column);

  drift.GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  drift.GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$ExpensesTableTableManager
    extends
        drift.RootTableManager<
          _$AppDb,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, drift.BaseReferences<_$AppDb, $ExpensesTable, Expense>),
          Expense,
          drift.PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDb db, $ExpensesTable table)
    : super(
        drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                drift.Value<String> id = const drift.Value.absent(),
                drift.Value<String> tripId = const drift.Value.absent(),
                drift.Value<String> category = const drift.Value.absent(),
                drift.Value<double> amount = const drift.Value.absent(),
                drift.Value<String> currency = const drift.Value.absent(),
                drift.Value<int> dateMs = const drift.Value.absent(),
                drift.Value<String> description = const drift.Value.absent(),
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                tripId: tripId,
                category: category,
                amount: amount,
                currency: currency,
                dateMs: dateMs,
                description: description,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String category,
                required double amount,
                drift.Value<String> currency = const drift.Value.absent(),
                required int dateMs,
                drift.Value<String> description = const drift.Value.absent(),
                drift.Value<bool> pendingSync = const drift.Value.absent(),
                drift.Value<int> rowid = const drift.Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                tripId: tripId,
                category: category,
                amount: amount,
                currency: currency,
                dateMs: dateMs,
                description: description,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), drift.BaseReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    drift.ProcessedTableManager<
      _$AppDb,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, drift.BaseReferences<_$AppDb, $ExpensesTable, Expense>),
      Expense,
      drift.PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
}
