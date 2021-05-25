<template>
  <div>
    <h1>Edit User</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="currentUserUsername" />
    <p v-if="errors.username" style="color: red">
      {{ errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="currentUserPassword" />
    <p v-if="errors.password" style="color: red">
      {{ errors.password[0] }}
    </p>

    <button type="submit" v-on:click="editUser(userId)">Save</button>
    <a href="/users">Back</a>
  </div>
</template>


<script>
import { reactive, inject, toRefs, computed } from "@vue/composition-api";
import axios from "axios";

export default {
  setup() {
    const state = reactive({
      errors: {},
    });

    const userList = inject("userList");
    if (!userList) {
      throw new Error(`userList is not provided`);
    }
    userList.getUser();

    const userId = parseInt(window.location.pathname.split("/")[2]);

    const currentUser = computed(() => {
      const user = userList.users.value.find((data) => data.id === userId);
      return user;
    });

    const currentUserUsername = computed({
      get: () => {
        if (currentUser.value) {
          return currentUser.value.username;
        } else {
          return "";
        }
      },
      set: (value) => {
        currentUser.value.username = value;
      },
    });

    const currentUserPassword = computed({
      get: () => {
        if (currentUser.value) {
          return currentUser.value.password;
        } else {
          return "";
        }
      },
      set: (value) => {
        currentUser.value.password = value;
      },
    });

    async function editUser(id) {
      try {
        await axios.put(`/api/users/${id}`, {
          id: id,
          user: {
            username: currentUserUsername.value,
            password: currentUserPassword.value,
          },
        });
        window.location.href = "/users";
      } catch (error) {
        console.error(error);
        if (error.response.data && error.response.data.errors) {
          state.errors = error.response.data.errors;
        }
      }
    }

    return {
      ...toRefs(state),
      userList,
      currentUserUsername,
      currentUserPassword,
      editUser,
      userId,
    };
  },
};
</script>

<style>
</style>