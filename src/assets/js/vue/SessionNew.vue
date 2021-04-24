<template>
  <div>
    <h1>Login</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="state.username" />
    <p v-if="state.errors.username" style="color: red">
      {{ state.errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="state.password" />
    <p v-if="state.errors.password" style="color: red">
      {{ state.errors.password[0] }}
    </p>

    <button type="submit" v-on:click="createSession" action="/">Log in</button>
  </div>
</template>


<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      username: "",
      password: "",
      errors: "",
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
        window.location.href = "/";
      } catch (error) {
        if (error.response.data && error.response.data.errors) {
          console.log(error);
          state.errors = error.response.data.errors;
        }
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