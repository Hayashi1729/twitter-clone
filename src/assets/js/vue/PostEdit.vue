<template>
  <div>
    <h1>Edit Post</h1>
    <form>
      <label for="post">Tweet</label>
      <input type="text" id="post" v-model="state.post.tweet" />

      <button type="submit" v-on:click="editPost(state.post.id)">Save</button>
    </form>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive, onMounted } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      post: [],
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
      } catch (error) {
        console.error(error);
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