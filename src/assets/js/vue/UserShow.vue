<template>
  <div>
    <h1>Show User</h1>

    <ul>
      <li>
        <strong>Username:</strong>
        {{ state.user.username }}
      </li>
    </ul>
    <a v-bind:href="currentURL + '/edit'">Edit</a>
    <a href="/users">Back</a>
  </div>
</template>

<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      user: [],
      currentURL: window.location.href,
    });

    axios.get("/api" + window.location.pathname).then(function (response) {
      state.user = response.data;
    });

    return {
      state,
    };
  },
};
</script>

<style>
</style>