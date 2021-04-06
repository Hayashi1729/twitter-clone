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
      <tbody>
        <div v-for="user in users" :key="user.id">
          <tr>
            <td>{{ user.username }}</td>

            <td>
              <a v-bind:href="'users/' + user.id">Show</a>
              <a v-bind:href="'users/' + user.id + '/edit'">Edit</a>
              <button v-on:click="deleteUser(user.id)">Delete</button>
            </td>
          </tr>
        </div>
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
    axios.get("api/users").then((response) => {
      this.users = response.data;
    });
  },
  methods: {
    deleteUser: function (id) {
      axios.delete("../api/users/" + id);

      axios.get("../api/users").then((response) => {
        this.posts = response.data;
      });
    },
  },
};
</script>

<style>
</style>