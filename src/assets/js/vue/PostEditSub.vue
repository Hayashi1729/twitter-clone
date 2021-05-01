<template>
  <div>
    <h1>Edit Post</h1>
    <label for="post">Tweet</label>

    <input type="text" id="post" v-model="currentPostTweet" />
    <p v-if="errors" style="color: red">
      {{ errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="editPost(postId)">Save</button>
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

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }

    const postId = parseInt(window.location.pathname.split("/")[2]);

    const postIndex = computed(() => {
      const index = postList.posts.value.findIndex(
        (data) => data.id === postId
      );

      return index;
    });

    const currentPostTweet = computed({
      get: () => {
        if (postList.posts.value[postIndex.value]) {
          return postList.posts.value[postIndex.value].tweet;
        } else {
          return "";
        }
      },
      set: (value) => {
        postList.posts.value[postIndex.value].tweet = value;
      },
    });

    async function editPost(id) {
      try {
        const response = await axios.put(`/api/posts/${id}`, {
          id: id,
          post: {
            tweet: currentPostTweet.value,
          },
        });
        window.location.href = "/posts";
      } catch (error) {
        if (error.response.data && error.response.data.errors) {
          console.error(error);
          state.errors = error.response.data.errors;
        }
      }
    }

    return {
      ...toRefs(state),
      currentPostTweet,
      editPost,
      postId,
    };
  },
};
</script>

<style>
</style>