<template>
  <div>
    <h1>Edit User</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="state.user.username" />
    <p v-if="state.errors.username" style="color: red">
      {{ state.errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="state.user.password" />
    <p v-if="state.errors.password" style="color: red">
      {{ state.errors.password[0] }}
    </p>

    <button type="submit" v-on:click="editUser(state.user.id)">Save</button>
    <a href="/users">Back</a>
  </div>
</template>


<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      user: [],
      errors: "",
    });

    const url = window.location.pathname.split("/");
    const getUser = async () => {
      const response = await axios.get(`/api/users/${url[2]}`);
      state.user = response.data;
    };

    onMounted(getUser);

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
      state,
      editUser,
    };
  },
};
</script>

<style>
</style>