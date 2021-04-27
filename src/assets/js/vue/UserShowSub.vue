<template>
  <div>
    <h1>Show User</h1>

    <ul>
      <li>
        <strong>Username:</strong>
        {{ getUser().username }}
      </li>
    </ul>
    <a v-bind:href="`${state.currentURL}/edit`">Edit</a>
    <a href="/users">Back</a>
  </div>
</template>

<script>
const { reactive, inject } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      currentURL: window.location.href,
    });

    const user_list = inject("user_list");
    if (!user_list) {
      throw new Error(`user_list is not provided`);
    }

    const id = window.location.pathname.split("/")[2];
    function getUser() {
      const userIndex = user_list.user.findIndex((data) => data.id == id);
      return user_list.user[userIndex];
    }

    return {
      getUser,
      state,
    };
  },
};
</script>

<style>
</style>