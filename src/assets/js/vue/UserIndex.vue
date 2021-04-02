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
              <span>Show</span>
              <span>Edit</span>
              <span>Delete</span>
            </td>
          </tr>
        </div>
      </tbody>
    </table>
    <span>New User</span>
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
};
</script>

<style>
</style>