<template>
  <div>
    <h1>Listing Users</h1>

    <table>
      <thead>
        <tr>
          <th>Username</th>

          <th></th>
        </tr>
      </thead>
      <tbody v-for="user in userList.users.value" :key="user.id">
        <tr>
          <td>{{ user.username }}</td>

          <td>
            <a v-bind:href="`/users/${user.id}`">Show</a>
            <a v-bind:href="`/users/${user.id}/edit`">Edit</a>
            <button v-on:click="deleteUser(user.id)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <a href="/users/new">New User</a>
    <br />
    <a href="/">トップページに戻る</a>
  </div>
</template>

<script>
import { setupUserList } from "./userKey";

export default {
  setup() {
    const userList = setupUserList();

    function deleteUser(id) {
      userList.deleteUser(id);
    }

    return {
      userList,
      deleteUser,
    };
  },
};
</script>

<style>
</style>