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
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      post: [],
      currentURL: window.location.href,
    });

    const getPost = async () => {
      const response = await axios.get("/api" + window.location.pathname);
      state.post = response.data;
    };

    onMounted(getPost);

    return {
      state,
    };
  },
};
</script>

<style>
</style>