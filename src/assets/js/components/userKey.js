import { provide, inject } from "@vue/composition-api";
import storeUser from "../stores/users";

const UserKey = Symbol('User')

function setupUserList() {
  provide(UserKey, storeUser());
  const userList = inject(UserKey);
  if (!userList) {
    throw new Error(`userList is not provided`);
  }
  userList.getUser();

  return userList
};

export { setupUserList };

