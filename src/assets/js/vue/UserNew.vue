<template>
  <div>
    <h1>New User</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="username" />
    <p v-if="errors.username" style="color: red">
      {{ errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="password" />
    <p v-if="errors.password" style="color: red">
      {{ errors.password[0] }}
    </p>

    <button type="submit" v-on:click="createUser" action="/">Save</button>

    <a href="/users">Back</a>
  </div>
</template>

<script>
const { reactive, toRefs } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      username: "",
      password: "",
      errors: "",
    });

    async function createUser() {
      try {
        const response = await axios.post("/api/users", {
          user: {
            username: state.username,
            password: state.password,
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
      createUser,
    };
  },
};
</script>

<style>
</style>