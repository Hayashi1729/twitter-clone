<template>
  <div>
    <h1>Login</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="password" />

      <button type="submit" v-on:click="createSession">Log in</button>
    </form>
  </div>
</template>


<script>
export default {
  data: {
    username: [],
    password: [],
  },
  methods: {
    async createSession() {
      try {
        const response = await axios.post("/sessions", {
          session: {
            username: this.username,
            password: this.password,
          },
        });
        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style>
</style>