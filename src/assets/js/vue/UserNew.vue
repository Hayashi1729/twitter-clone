<template>
  <div>
    <h1>New User</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="password" />

      <button type="submit" v-on:click="createUser">Save</button>
    </form>
    <a href="/users">Back</a>
  </div>
</template>

<script>
export default {
  data: {
    username: "",
    password: "",
  },
  methods: {
    async createUser() {
      axios
        .post("/api/users", {
          user: {
            username: this.username,
            password: this.password,
          },
        })
        .then((response) => {
          console.log("Username:" + response.data.username);
        });
    },
  },
};
</script>

<style>
</style>