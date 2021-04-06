<template>
  <div>
    <h1>New Post</h1>
    <form>
      <label for="tweet">Tweet</label>
      <input type="text" id="tweet" v-model="tweet" />

      <button type="submit" v-on:click="createPost">Save</button>
    </form>
    <a href="./">Back</a>
  </div>
</template>

<script>
export default {
  data: {
    tweet: "",
  },
  methods: {
    createPost: function () {
      axios
        .post("../api/posts", {
          post: {
            tweet: "test tweet",
          },
        })
        .then((response) => {
          console.log("Tweet:" + response.data.tweet);
        });
    },
  },
};
</script>

<style>
</style>