<template>
  <div>
    <h1>Show Post</h1>

    <ul>
      <li>
        <strong>Tweet:</strong>
        {{ post.tweet }}
      </li>

      <li>
        <strong>Username:</strong>
        {{ post.user.username }}
      </li>
    </ul>
    <a v-bind:href="currentURL + '/edit'">Edit</a>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
export default {
  data() {
    return {
      post: [],
      currentURL: window.location.href,
    };
  },
  async created() {
    try {
      const response = await axios.get("/api" + window.location.pathname);
      this.post = response.data;
    } catch (error) {
      console.error(error);
    }
  },
};
</script>

<style>
</style>