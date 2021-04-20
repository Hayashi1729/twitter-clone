<template>
  <div>
    <h1>Login</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="state.username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="state.password" />

      <button type="submit" v-on:click="createSession">Log in</button>
    </form>
  </div>
</template>


<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      username: [],
      password: [],
    });

    async function createSession() {
      try {
        const response = await axios.post("/sessions", {
          session: {
            username: state.username,
            password: state.password,
          },
        });
        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
    }

    return {
      state,
      createSession,
    };
  },
};
</script>

<style>
</style>