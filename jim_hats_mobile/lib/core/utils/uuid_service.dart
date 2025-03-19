import 'package:uuid/uuid.dart';

class UuidService {
  bool isValid(String uuid) {
    return Uuid.isValidUUID(fromString: uuid);
  }
}
