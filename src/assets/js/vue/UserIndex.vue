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
      <tbody v-for="user in state.users" :key="user.id">
        <tr>
          <td>{{ user.username }}</td>

          <td>
            <a v-bind:href="'/users/' + user.id">Show</a>
            <a v-bind:href="'/users/' + user.id + '/edit'">Edit</a>
            <button v-on:click="deleteUser(user.id)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <a href="/users/new">New User</a>
  </div>
</template>

<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      users: [],
    });

    const getUsers = async () => {
      const response = await axios.get("/api/users");
      state.users = response.data;
    };

    onMounted(getUsers);

    async function deleteUser(id) {
      try {
        const response = await axios.delete("/api/users/" + id);
        state.users = state.users.filter((user) => user.id !== id);
      } catch (error) {
        console.error(error);
      }
    }

    return {
      state,
      deleteUser,
    };
  },
};
</script>

<style>
</style>