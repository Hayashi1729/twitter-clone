<template>
  <div>
    <h1>Edit Post</h1>
    <form>
      <label for="tweet">Tweet</label>
      <input type="text" id="tweet" name="tweet" />

      <button type="submit" v-on:click="editPost">Save</button>
    </form>
    <a href="../../posts">Back</a>
  </div>
</template>

<script>
export default {
  data: {
    tweet: [],
  },
  methods: {
    editPost: function () {
      let params = new URLSearchParams();
      params.append("tweet", this.tweet);
      axios.post("../api/posts", params).then((response) => {
        console.log(response.data.tweet);
      });
    },
  },
};
</script>

<style>
</style>