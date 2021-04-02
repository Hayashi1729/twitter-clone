<template>
  <div>
    <h1>New Post</h1>
    <form>
      <label for="tweet">Tweet</label>
      <input type="text" id="tweet" name="tweet" />

      <button type="submit" v-on:click="createPost">Save</button>
    </form>
    <a href="./">Back</a>
  </div>
</template>

<script>
export default {
  data: {
    tweet: [],
  },
  method: {
    createPost: function () {
      let params = new URLSearchParams();
      params.append("tweet", tweet);
      axios.post("../api/posts", params).then((response) => {
        console.log("Tweet:" + response.data.tweet);
      });
    },
  },
};
</script>

<style>
</style>