<template>
  <div>
    <h1>Edit User</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="getUser().username" />
    <p v-if="errors.username" style="color: red">
      {{ errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="getUser().password" />
    <p v-if="errors.password" style="color: red">
      {{ errors.password[0] }}
    </p>

    <button type="submit" v-on:click="editUser(getUser().id)">Save</button>
    <a href="/users">Back</a>
  </div>
</template>


<script>
const { reactive, inject, toRefs } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      errors: "",
    });

    const user_list = inject("user_list");
    if (!user_list) {
      throw new Error(`user_list is not provided`);
    }
    const user_id = parseInt(window.location.pathname.split("/")[2]);
    function getUser() {
      const userIndex = user_list.users.value.findIndex(
        (data) => data.id === user_id
      );
      return user_list.users.value[userIndex];
    }

    async function editUser(id) {
      try {
        const response = await axios.put(`/api/users/${id}`, {
          id: id,
          user: {
            username: state.user.username,
            password: state.user.password,
          },
        });
        console.log(response.data.user);
        window.location.href = "/users";
      } catch (error) {
        if (error.response.data && error.response.data.errors) {
          console.log(error);
          state.errors = error.response.data.errors;
        }
      }
    }

    return {
      ...toRefs(state),
      getUser,
      editUser,
    };
  },
};
</script>

<style>
</style>