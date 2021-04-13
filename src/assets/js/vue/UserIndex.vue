<template>
  <div>
    <h1>Listing Users</h1>

    <table>
      <thead>
        <tr>
          <th>Username</th>

          <th></th>
        </tr>
      </thead>
      <tbody v-for="user in users" :key="user.id">
        <tr>
          <td>{{ user.username }}</td>

          <td>
            <a v-bind:href="'users/' + user.id">Show</a>
            <a v-bind:href="'users/' + user.id + '/edit'">Edit</a>
            <button v-on:click="deleteUser(user.id)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <a href="users/new">New User</a>
  </div>
</template>

<script>
export default {
  data() {
    return {
      users: [],
    };
  },
  created: function () {
    axios.get("../api/users").then((response) => {
      this.users = response.data;
    });
  },
  methods: {
    async deleteUser(id) {
      try {
        const response = await axios.delete("/api/users/" + id);
        this.users = this.users.filter((user) => user.id !== id);
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style>
</style>