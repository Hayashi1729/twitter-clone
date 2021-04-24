<template>
  <div>
    <h1>Show User</h1>

    <ul>
      <li>
        <strong>Username:</strong>
        {{ state.user.username }}
      </li>
    </ul>
    <a v-bind:href="`${state.currentURL}/edit`">Edit</a>
    <a href="/users">Back</a>
  </div>
</template>

<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      user: [],
      currentURL: window.location.href,
    });

    const getUser = async () => {
      const response = await axios.get("/api" + window.location.pathname);
      state.user = response.data;
    };

    onMounted(getUser);

    return {
      state,
    };
  },
};
</script>

<style>
</style>