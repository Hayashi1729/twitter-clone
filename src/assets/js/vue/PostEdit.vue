<template>
  <div>
    <h1>Edit Post</h1>
    <label for="post">Tweet</label>
    <input type="text" id="post" v-model="state.post.tweet" />
    <p v-if="state.errors" style="color: red">
      {{ state.errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="editPost(state.post.id)">Save</button>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      post: [],
      errors: "",
    });

    const url = window.location.pathname.split("/");
    const getPost = async () => {
      const response = await axios.get("/api/posts/" + url[2]);
      state.post = response.data;
    };

    onMounted(getPost);

    async function editPost(id) {
      try {
        const response = await axios.put("/api/posts/" + id, {
          id: post.id,
          post: {
            tweet: state.post.tweet,
          },
        });
        console.log(response.data.tweet);
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
      editPost,
    };
  },
};
</script>

<style>
</style>