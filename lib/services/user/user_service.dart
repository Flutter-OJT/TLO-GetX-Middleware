import 'package:authentications/repository/crud_user_repository.dart';
import 'package:get/get.dart';
import '../../models/user/user_model.dart';

class UserService {
  final CrudUserRepository userrepo = CrudUserRepository();
  RxList<UserModel> userList = <UserModel>[].obs;
  Future<void> createUser(UserModel newUser) async {
    int? id = await userrepo.create(newUser.toMap());
    if (id != null) {
      newUser.id = id;
      userList.add(newUser);
    }
  }

  Future<void> updateUser(UserModel updatedUser, int id) async {
    updatedUser.id = id;
    await userrepo.update(id, updatedUser.toMap());

    int index = userList.indexWhere((user) => user.id == id);
    if (index != -1) {
      userList[index].id = id;
      userList[index].name = updatedUser.name;
      userList[index].email = updatedUser.email;
      userList[index].password = updatedUser.password;
      userList[index].role = updatedUser.role;
      userList.refresh(); // Notify observers about the change
    }
  }

  Future<void> deleteUser(int? id) async {
    if (id != null) {
      await userrepo.delete(id);
      userList.removeWhere((user) => user.id == id);
    }
  }
}
