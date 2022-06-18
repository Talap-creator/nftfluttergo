import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'add_nft_record.g.dart';

abstract class AddNftRecord
    implements Built<AddNftRecord, AddNftRecordBuilder> {
  static Serializer<AddNftRecord> get serializer => _$addNftRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'create_nft')
  String get createNft;

  @nullable
  @BuiltValueField(wireName: 'nft_price')
  int get nftPrice;

  @nullable
  @BuiltValueField(wireName: 'created_by')
  DocumentReference get createdBy;

  @nullable
  String get titlenft;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AddNftRecordBuilder builder) => builder
    ..createNft = ''
    ..nftPrice = 0
    ..titlenft = ''
    ..description = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('add_nft');

  static Stream<AddNftRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<AddNftRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AddNftRecord._();
  factory AddNftRecord([void Function(AddNftRecordBuilder) updates]) =
      _$AddNftRecord;

  static AddNftRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createAddNftRecordData({
  String createNft,
  int nftPrice,
  DocumentReference createdBy,
  String titlenft,
  String description,
}) =>
    serializers.toFirestore(
        AddNftRecord.serializer,
        AddNftRecord((a) => a
          ..createNft = createNft
          ..nftPrice = nftPrice
          ..createdBy = createdBy
          ..titlenft = titlenft
          ..description = description));
