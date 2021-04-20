<template>
  <div>
    <h1>Show Post</h1>

    <ul>
      <li>
        <strong>Tweet:</strong>
        {{ state.post.tweet }}
      </li>

      <li>
        <strong>Username:</strong>
        {{ state.post.user.username }}
      </li>
    </ul>
    <a v-bind:href="state.currentURL + '/edit'">Edit</a>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      post: [],
      currentURL: window.location.href,
    });

    axios.get("/api" + window.location.pathname).then(function (response) {
      state.post = response.data;
    });

    return {
      state,
    };
  },
};
</script>

<style>
</style>