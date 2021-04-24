<template>
  <div>
    <h1>New Post</h1>

    <label for="tweet">Tweet</label>
    <input type="text" id="tweet" v-model="state.tweet" />
    <p v-if="state.errors" style="color: red">
      {{ state.errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="createPost">Save</button>

    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      tweet: "",
      errors: "",
    });

    async function createPost() {
      try {
        const response = await axios.post("/api/posts", {
          post: { tweet: state.tweet },
        });
        console.log("Tweet:" + response.data.tweet);
        window.location.href = "/posts";
      } catch (error) {
        if (error.response.data && error.response.data.errors) {
          console.log(error);
          state.errors = error.response.data.errors;
        }
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