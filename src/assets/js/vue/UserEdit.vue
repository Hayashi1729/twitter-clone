<template>
  <div>
    <h1>Edit User</h1>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="state.user.username" />

      <label for="password">Password</label>
      <input type="password" id="password" v-model="state.user.password" />

      <button type="submit" v-on:click="editUser(state.user.id)">Save</button>
    </form>
    <a href="/users">Back</a>
  </div>
</template>


<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      user: [],
    });

    const url = window.location.pathname.split("/");
    const getUser = async () => {
      const response = await axios.get("/api/users/" + url[2]);
      state.user = response.data;
    };

    onMounted(getUser);

    async function editUser(id) {
      try {
        const response = await axios.put("/api/users/" + id, {
          id: id,
          user: {
            username: state.user.username,
            password: state.user.password,
          },
        });
        console.log(response.data.user);
      } catch (error) {
        console.error(error);
      }
    }

    return {
      state,
      editUser,
    };
  },
};
</script>

<style>
</style>