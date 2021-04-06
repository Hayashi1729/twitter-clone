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
    <a href="../posts">Back</a>
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
  created: function () {
    axios.get("../api/" + window.location.pathname).then((response) => {
      this.post = response.data;
    });
  },
};
</script>

<style>
</style>