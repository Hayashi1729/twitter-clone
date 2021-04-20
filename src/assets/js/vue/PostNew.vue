<template>
  <div>
    <h1>New Post</h1>
    <form>
      <label for="tweet">Tweet</label>
      <input type="text" id="tweet" v-model="state.tweet" />

      <button type="submit" v-on:click="createPost">Save</button>
    </form>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      tweet: "",
    });

    async function createPost() {
      try {
        const response = await axios.post("/api/posts", {
          post: { tweet: state.tweet },
        });
        console.log("Tweet:" + response.data.tweet);
      } catch (error) {
        console.error(error);
      }
    }

    return {
      state,
      createPost,
    };
  },
};
</script>

<style>
</style>