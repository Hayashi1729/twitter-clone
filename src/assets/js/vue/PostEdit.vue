<template>
  <div>
    <h1>Edit Post</h1>
    <form>
      <label for="post">Tweet</label>
      <input type="text" id="post" v-model="tweet" />

      <button type="submit" v-on:click="editPost(post.id)">Save</button>
    </form>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
export default {
  data: {
    post: [],
  },
  async created() {
    try {
      const url = window.location.pathname.split("/");
      const response = await axios.get("/api/posts/" + url[2]);
      console.log(response);
      this.post = response.data;
    } catch (error) {
      console.error(error);
    }
  },
  methods: {
    async editPost(id) {
      try {
        const response = await axios.put("/api/posts/" + id, {
          id: post.id,
          post: {
            tweet: this.tweet,
          },
        });
        console.log(response.data.tweet);
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style>
</style>