import 'package:jim_hats_mobile/core/utils/uuid_service.dart';
import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';

class GroupCodeValidator implements Validatable<String> {
  final UuidService _uuidService;
  GroupCodeValidator({
    UuidService? uuidService,
  }) : _uuidService = uuidService ?? UuidService();
  @override
  String? validate(String? groupCode) {
    if (groupCode == null || groupCode.isEmpty) {
      return 'Group code is required';
    }

    if (!_uuidService.isValid(groupCode)) {
      return 'Invalid group code';
    }
    return null;
  }
}
