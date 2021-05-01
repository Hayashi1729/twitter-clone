<template>
  <div>
    <h1>Edit Post</h1>
    <label for="post">Tweet</label>
    <input type="text" id="post" v-model="getPost.tweet" />
    <p v-if="errors" style="color: red">
      {{ errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="editPost(getPost.id)">Save</button>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive, inject, toRefs, computed } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      errors: "",
    });

    const post_list = inject("post_list");
    if (!post_list) {
      throw new Error(`post_list is not provided`);
    }

    const getPost = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const postIndex = post_list.posts.value.findIndex(
        (data) => data.id === id
      );
      return post_list.posts.value[postIndex];
    });

    //const post_id = parseInt(window.location.pathname.split("/")[2]);
    //function getPost() {
    //  const postIndex = post_list.posts.value.findIndex(
    //    (data) => data.id === post_id
    //  );
    //  return post_list.posts.value[postIndex];
    //}

    async function editPost(id) {
      try {
        const response = await axios.put(`/api/posts/${id}`, {
          id: id,
          post: {
            tweet: getPost.tweet,
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
      ...toRefs(state),
      getPost,
      editPost,
    };
  },
};
</script>

<style>
</style>