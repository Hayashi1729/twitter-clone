<template>
  <div>
    <h1>New User</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="state.username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="state.password" />

      <button type="submit" v-on:click="createUser">Save</button>
    </form>
    <a href="/users">Back</a>
  </div>
</template>

<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      username: "",
      password: "",
    });

    async function createUser() {
      try {
        const response = await axios.post("/api/users", {
          user: {
            username: state.username,
            password: state.password,
          },
        });
        console.log("Username:" + response.data.username);
      } catch (error) {
        console.error(error);
      }
    }

    return {
      state,
      createUser,
    };
  },
};
</script>

<style>
</style>