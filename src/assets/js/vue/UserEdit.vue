<template>
  <div>
    <h1>Edit User</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="password" />

      <button type="submit" v-on:click="createUser">Save</button>
    </form>
    <a href="./">Back</a>
  </div>
</template>


<script>
export default {
  data: {
    username: [],
    password: [],
  },
  methods: {
    editPost: function () {
      let params = new URLSearchParams();
      params.append("username", this.username);
      params.append("password", this.password);
      axios.post("../api/users", params).then((response) => {
        console.log(response.data.username);
      });
    },
  },
};
</script>

<style>
</style>