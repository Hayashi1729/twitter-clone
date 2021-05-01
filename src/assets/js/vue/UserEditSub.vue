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
const { reactive, inject, toRefs, computed } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      errors: "",
    });

    const user_list = inject("user_list");
    if (!user_list) {
      throw new Error(`user_list is not provided`);
    }
    const userId = parseInt(window.location.pathname.split("/")[2]);

    const userIndex = computed(() => {
      const index = user_list.users.value.findIndex(
        (data) => data.id === userId
      );

      return index;
    });

    const currentUserUsername = computed({
      get: () => {
        if (user_list.users.value[userIndex.value]) {
          return user_list.users.value[userIndex.value].username;
        } else {
          return "";
        }
      },
      set: (value) => {
        user_list.users.value[userIndex.value].username = value;
      },
    });

    const currentUserPassword = computed({
      get: () => {
        if (user_list.users.value[userIndex.value]) {
          return user_list.users.value[userIndex.value].password;
        } else {
          return "";
        }
      },
      set: (value) => {
        user_list.users.value[userIndex.value].password = value;
      },
    });

    async function editUser(id) {
      try {
        const response = await axios.put(`/api/users/${id}`, {
          id: id,
          user: {
            username: currentUserUsername.value,
            password: currentUserUsername.value,
          },
        });
        window.location.href = "/users";
      } catch (error) {
        if (error.response.data && error.response.data.errors) {
          console.error(error);
          state.errors = error.response.data.errors;
        }
      }
    }

    return {
      ...toRefs(state),
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