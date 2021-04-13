<template>
  <div>
    <h1>Edit User</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="password" />

      <button type="submit" v-on:click="editUser(user.id)">Save</button>
    </form>
    <a href="/users">Back</a>
  </div>
</template>


<script>
export default {
  data: {
    user: [],
  },
  async created() {
    try {
      const url = window.location.pathname.split("/");
      const response = await axios.get("/api/users/" + url[2]);
      console.log(response);
      this.user = response.data;
    } catch (error) {
      console.error(error);
    }
  },
  methods: {
    async editUser(id) {
      try {
        const response = await axios.put("/api/users/" + id, {
          id: id,
          user: {
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