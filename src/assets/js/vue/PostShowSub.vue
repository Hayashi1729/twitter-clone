<template>
  <div>
    <h1>Show Post</h1>

    <ul>
      <li>
        <strong>Tweet:</strong>
        {{ getPost().tweet }}
      </li>

      <li>
        <strong>Username:</strong>
        {{ getPost().user.username }}
      </li>
    </ul>
    <a v-bind:href="`${state.currentURL}/edit`">Edit</a>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive, inject } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      currentURL: window.location.href,
    });

    const post_list = inject("post_list");
    console.log(post_list);
    if (!post_list) {
      throw new Error(`post_list is not provided`);
    }
    const id = window.location.pathname.split("/")[2];
    function getPost() {
      const postIndex = post_list.post.findIndex((data) => data.id == id);
      return post_list.post[postIndex];
    }

    return {
      getPost,
      state,
    };
  },
};
</script>

<style>
</style>