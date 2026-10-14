/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:equip_link_server/src/generated/domain/equipment_category.dart'
    as _iq4knvor;
import 'package:equip_link_server/src/generated/domain/equipment_listing.dart'
    as _isdyr86w;
import 'package:equip_link_server/src/generated/domain/rental_request.dart'
    as _i53zcwg3;
import 'package:equip_link_server/src/generated/domain/rental_status_history.dart'
    as _ivhwgugx;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'auth/email_otp_challenge.dart' as _ittyyj72;
import 'auth/otp_challenge_response.dart' as _if3qksxc;
import 'auth/student_email_challenge_response.dart' as _ip3dtseu;
import 'auth/student_email_verification_challenge.dart' as _i6sm5mkm;
import 'auth/student_id_card_upload.dart' as _iv0b1ynq;
import 'auth/student_identity.dart' as _ipmhl12h;
import 'domain/availability_result.dart' as _i0jrckiv;
import 'domain/equiplink_exception.dart' as _in36mdvu;
import 'domain/equipment_category.dart' as _i39ay6zn;
import 'domain/equipment_listing.dart' as _iz96b8i7;
import 'domain/handover_confirmation.dart' as _ivlvljr1;
import 'domain/rental_request.dart' as _ihit20mm;
import 'domain/rental_review.dart' as _ilrkrvol;
import 'domain/rental_status_history.dart' as _iw7aivv3;
import 'domain/student_profile.dart' as _iw7fsyfy;
import 'greetings/greeting.dart' as _izw8z7ou;
export 'auth/email_otp_challenge.dart';
export 'auth/otp_challenge_response.dart';
export 'auth/student_email_challenge_response.dart';
export 'auth/student_email_verification_challenge.dart';
export 'auth/student_id_card_upload.dart';
export 'auth/student_identity.dart';
export 'domain/availability_result.dart';
export 'domain/equiplink_exception.dart';
export 'domain/equipment_category.dart';
export 'domain/equipment_listing.dart';
export 'domain/handover_confirmation.dart';
export 'domain/rental_request.dart';
export 'domain/rental_review.dart';
export 'domain/rental_status_history.dart';
export 'domain/student_profile.dart';
export 'greetings/greeting.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'email_otp_challenge',
      dartName: 'EmailOtpChallenge',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'challengeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'codeHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'salt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'issuedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'attempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'maxAttempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'consumed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'requestIp',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userAgent',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'preAuthNonce',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'email_otp_challenge_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'challengeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'email_otp_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'equipment_category',
      dartName: 'EquipmentCategory',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'iconName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'equipment_category_slug_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'equipment_listing',
      dartName: 'EquipmentListing',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'hourlyRate',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'dailyRate',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'securityDeposit',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'condition',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'locationCampus',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrls',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'equipment_listing_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'equipment_listing_category_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'equipment_listing_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'handover_confirmation',
      dartName: 'HandoverConfirmation',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'rentalRequestId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'confirmedByOwner',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'confirmedByRenter',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'handoverCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'itemConditionNotes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'confirmedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'handover_confirmation_rental_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'rentalRequestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_request',
      dartName: 'RentalRequest',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'listingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'renterId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'startDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'totalDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'dailyRate',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'totalAmount',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'securityDeposit',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rental_request_listing_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'rental_request_renter_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'renterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'rental_request_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'rental_request_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_review',
      dartName: 'RentalReview',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'rentalRequestId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'reviewerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'revieweeId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'listingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rating',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'comment',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rental_review_rental_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'rentalRequestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_status_history',
      dartName: 'RentalStatusHistory',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'rentalRequestId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'changedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rental_status_history_rental_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'rentalRequestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_email_verification_challenge',
      dartName: 'StudentEmailVerificationChallenge',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'challengeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'codeHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'salt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'issuedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'attempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'maxAttempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'consumed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'requestIp',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userAgent',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_email_challenge_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'challengeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_email_challenge_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_email_challenge_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_identity',
      dartName: 'StudentIdentity',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'googleProviderIdentity',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'studentEmail',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'university',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'studentIdCardPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'studentIdExpiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'studentIdCardVerified',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'emailVerified',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastRevalidatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'revalidationDueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'eligibilityStatus',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_identity_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_identity_google_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'googleProviderIdentity',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_identity_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'studentEmail',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_profile',
      dartName: 'StudentProfile',
      schema: 'public',
      module: 'equip_link',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'fullName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'university',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'studentIdNumber',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'phoneNumber',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'avatarUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isVerified',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_profile_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_profile_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ittyyj72.EmailOtpChallenge) {
      return _ittyyj72.EmailOtpChallenge.fromJson(data) as T;
    }
    if (t == _if3qksxc.OtpChallengeResponse) {
      return _if3qksxc.OtpChallengeResponse.fromJson(data) as T;
    }
    if (t == _ip3dtseu.StudentEmailChallengeResponse) {
      return _ip3dtseu.StudentEmailChallengeResponse.fromJson(data) as T;
    }
    if (t == _i6sm5mkm.StudentEmailVerificationChallenge) {
      return _i6sm5mkm.StudentEmailVerificationChallenge.fromJson(data) as T;
    }
    if (t == _iv0b1ynq.StudentIdCardUpload) {
      return _iv0b1ynq.StudentIdCardUpload.fromJson(data) as T;
    }
    if (t == _ipmhl12h.StudentIdentity) {
      return _ipmhl12h.StudentIdentity.fromJson(data) as T;
    }
    if (t == _i0jrckiv.AvailabilityResult) {
      return _i0jrckiv.AvailabilityResult.fromJson(data) as T;
    }
    if (t == _in36mdvu.EquipLinkException) {
      return _in36mdvu.EquipLinkException.fromJson(data) as T;
    }
    if (t == _i39ay6zn.EquipmentCategory) {
      return _i39ay6zn.EquipmentCategory.fromJson(data) as T;
    }
    if (t == _iz96b8i7.EquipmentListing) {
      return _iz96b8i7.EquipmentListing.fromJson(data) as T;
    }
    if (t == _ivlvljr1.HandoverConfirmation) {
      return _ivlvljr1.HandoverConfirmation.fromJson(data) as T;
    }
    if (t == _ihit20mm.RentalRequest) {
      return _ihit20mm.RentalRequest.fromJson(data) as T;
    }
    if (t == _ilrkrvol.RentalReview) {
      return _ilrkrvol.RentalReview.fromJson(data) as T;
    }
    if (t == _iw7aivv3.RentalStatusHistory) {
      return _iw7aivv3.RentalStatusHistory.fromJson(data) as T;
    }
    if (t == _iw7fsyfy.StudentProfile) {
      return _iw7fsyfy.StudentProfile.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _is.getType<_ittyyj72.EmailOtpChallenge?>()) {
      return (data != null ? _ittyyj72.EmailOtpChallenge.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_if3qksxc.OtpChallengeResponse?>()) {
      return (data != null
              ? _if3qksxc.OtpChallengeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ip3dtseu.StudentEmailChallengeResponse?>()) {
      return (data != null
              ? _ip3dtseu.StudentEmailChallengeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6sm5mkm.StudentEmailVerificationChallenge?>()) {
      return (data != null
              ? _i6sm5mkm.StudentEmailVerificationChallenge.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iv0b1ynq.StudentIdCardUpload?>()) {
      return (data != null
              ? _iv0b1ynq.StudentIdCardUpload.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipmhl12h.StudentIdentity?>()) {
      return (data != null ? _ipmhl12h.StudentIdentity.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0jrckiv.AvailabilityResult?>()) {
      return (data != null ? _i0jrckiv.AvailabilityResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in36mdvu.EquipLinkException?>()) {
      return (data != null ? _in36mdvu.EquipLinkException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i39ay6zn.EquipmentCategory?>()) {
      return (data != null ? _i39ay6zn.EquipmentCategory.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz96b8i7.EquipmentListing?>()) {
      return (data != null ? _iz96b8i7.EquipmentListing.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivlvljr1.HandoverConfirmation?>()) {
      return (data != null
              ? _ivlvljr1.HandoverConfirmation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ihit20mm.RentalRequest?>()) {
      return (data != null ? _ihit20mm.RentalRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilrkrvol.RentalReview?>()) {
      return (data != null ? _ilrkrvol.RentalReview.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iw7aivv3.RentalStatusHistory?>()) {
      return (data != null
              ? _iw7aivv3.RentalStatusHistory.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iw7fsyfy.StudentProfile?>()) {
      return (data != null ? _iw7fsyfy.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iq4knvor.EquipmentCategory>) {
      return (data as List)
              .map((e) => deserialize<_iq4knvor.EquipmentCategory>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_isdyr86w.EquipmentListing>) {
      return (data as List)
              .map((e) => deserialize<_isdyr86w.EquipmentListing>(e))
              .toList()
          as T;
    }
    if (t == List<_i53zcwg3.RentalRequest>) {
      return (data as List)
              .map((e) => deserialize<_i53zcwg3.RentalRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_ivhwgugx.RentalStatusHistory>) {
      return (data as List)
              .map((e) => deserialize<_ivhwgugx.RentalStatusHistory>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ittyyj72.EmailOtpChallenge => 'EmailOtpChallenge',
      _if3qksxc.OtpChallengeResponse => 'OtpChallengeResponse',
      _ip3dtseu.StudentEmailChallengeResponse =>
        'StudentEmailChallengeResponse',
      _i6sm5mkm.StudentEmailVerificationChallenge =>
        'StudentEmailVerificationChallenge',
      _iv0b1ynq.StudentIdCardUpload => 'StudentIdCardUpload',
      _ipmhl12h.StudentIdentity => 'StudentIdentity',
      _i0jrckiv.AvailabilityResult => 'AvailabilityResult',
      _in36mdvu.EquipLinkException => 'EquipLinkException',
      _i39ay6zn.EquipmentCategory => 'EquipmentCategory',
      _iz96b8i7.EquipmentListing => 'EquipmentListing',
      _ivlvljr1.HandoverConfirmation => 'HandoverConfirmation',
      _ihit20mm.RentalRequest => 'RentalRequest',
      _ilrkrvol.RentalReview => 'RentalReview',
      _iw7aivv3.RentalStatusHistory => 'RentalStatusHistory',
      _iw7fsyfy.StudentProfile => 'StudentProfile',
      _izw8z7ou.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('equip_link.', '');
    }

    switch (data) {
      case _ittyyj72.EmailOtpChallenge():
        return 'EmailOtpChallenge';
      case _if3qksxc.OtpChallengeResponse():
        return 'OtpChallengeResponse';
      case _ip3dtseu.StudentEmailChallengeResponse():
        return 'StudentEmailChallengeResponse';
      case _i6sm5mkm.StudentEmailVerificationChallenge():
        return 'StudentEmailVerificationChallenge';
      case _iv0b1ynq.StudentIdCardUpload():
        return 'StudentIdCardUpload';
      case _ipmhl12h.StudentIdentity():
        return 'StudentIdentity';
      case _i0jrckiv.AvailabilityResult():
        return 'AvailabilityResult';
      case _in36mdvu.EquipLinkException():
        return 'EquipLinkException';
      case _i39ay6zn.EquipmentCategory():
        return 'EquipmentCategory';
      case _iz96b8i7.EquipmentListing():
        return 'EquipmentListing';
      case _ivlvljr1.HandoverConfirmation():
        return 'HandoverConfirmation';
      case _ihit20mm.RentalRequest():
        return 'RentalRequest';
      case _ilrkrvol.RentalReview():
        return 'RentalReview';
      case _iw7aivv3.RentalStatusHistory():
        return 'RentalStatusHistory';
      case _iw7fsyfy.StudentProfile():
        return 'StudentProfile';
      case _izw8z7ou.Greeting():
        return 'Greeting';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'EmailOtpChallenge') {
      return deserialize<_ittyyj72.EmailOtpChallenge>(data['data']);
    }
    if (dataClassName == 'OtpChallengeResponse') {
      return deserialize<_if3qksxc.OtpChallengeResponse>(data['data']);
    }
    if (dataClassName == 'StudentEmailChallengeResponse') {
      return deserialize<_ip3dtseu.StudentEmailChallengeResponse>(data['data']);
    }
    if (dataClassName == 'StudentEmailVerificationChallenge') {
      return deserialize<_i6sm5mkm.StudentEmailVerificationChallenge>(
        data['data'],
      );
    }
    if (dataClassName == 'StudentIdCardUpload') {
      return deserialize<_iv0b1ynq.StudentIdCardUpload>(data['data']);
    }
    if (dataClassName == 'StudentIdentity') {
      return deserialize<_ipmhl12h.StudentIdentity>(data['data']);
    }
    if (dataClassName == 'AvailabilityResult') {
      return deserialize<_i0jrckiv.AvailabilityResult>(data['data']);
    }
    if (dataClassName == 'EquipLinkException') {
      return deserialize<_in36mdvu.EquipLinkException>(data['data']);
    }
    if (dataClassName == 'EquipmentCategory') {
      return deserialize<_i39ay6zn.EquipmentCategory>(data['data']);
    }
    if (dataClassName == 'EquipmentListing') {
      return deserialize<_iz96b8i7.EquipmentListing>(data['data']);
    }
    if (dataClassName == 'HandoverConfirmation') {
      return deserialize<_ivlvljr1.HandoverConfirmation>(data['data']);
    }
    if (dataClassName == 'RentalRequest') {
      return deserialize<_ihit20mm.RentalRequest>(data['data']);
    }
    if (dataClassName == 'RentalReview') {
      return deserialize<_ilrkrvol.RentalReview>(data['data']);
    }
    if (dataClassName == 'RentalStatusHistory') {
      return deserialize<_iw7aivv3.RentalStatusHistory>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iw7fsyfy.StudentProfile>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('equip_link', this);
    _iacs.Protocol().registerHostProtocol('equip_link', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ittyyj72.EmailOtpChallenge:
        return _ittyyj72.EmailOtpChallenge.t;
      case _i6sm5mkm.StudentEmailVerificationChallenge:
        return _i6sm5mkm.StudentEmailVerificationChallenge.t;
      case _ipmhl12h.StudentIdentity:
        return _ipmhl12h.StudentIdentity.t;
      case _i39ay6zn.EquipmentCategory:
        return _i39ay6zn.EquipmentCategory.t;
      case _iz96b8i7.EquipmentListing:
        return _iz96b8i7.EquipmentListing.t;
      case _ivlvljr1.HandoverConfirmation:
        return _ivlvljr1.HandoverConfirmation.t;
      case _ihit20mm.RentalRequest:
        return _ihit20mm.RentalRequest.t;
      case _ilrkrvol.RentalReview:
        return _ilrkrvol.RentalReview.t;
      case _iw7aivv3.RentalStatusHistory:
        return _iw7aivv3.RentalStatusHistory.t;
      case _iw7fsyfy.StudentProfile:
        return _iw7fsyfy.StudentProfile.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'equip_link';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
