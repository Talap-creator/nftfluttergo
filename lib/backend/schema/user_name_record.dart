import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_name_record.g.dart';

abstract class UserNameRecord
    implements Built<UserNameRecord, UserNameRecordBuilder> {
  static Serializer<UserNameRecord> get serializer =>
      _$userNameRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_name')
  String get userName;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserNameRecordBuilder builder) =>
      builder..userName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_name');

  static Stream<UserNameRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserNameRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserNameRecord._();
  factory UserNameRecord([void Function(UserNameRecordBuilder) updates]) =
      _$UserNameRecord;

  static UserNameRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserNameRecordData({
  String userName,
}) =>
    serializers.toFirestore(UserNameRecord.serializer,
        UserNameRecord((u) => u..userName = userName));
