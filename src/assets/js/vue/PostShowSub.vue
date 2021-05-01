<template>
  <div v-if="currentUser">
    <h1>Show Post</h1>

    <ul>
      <li>
        <strong>Tweet:</strong>
        {{ currentUser.tweet }}
      </li>

      <li>
        <strong>Username:</strong>
        {{ currentUser.user.username }}
      </li>
    </ul>
    <a v-bind:href="`${state.currentURL}/edit`">Edit</a>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
const { reactive, inject, computed } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      currentURL: window.location.href,
    });

    const post_list = inject("post_list");
    if (!post_list) {
      throw new Error(`post_list is not provided`);
    }

    const currentUser = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const postIndex = post_list.posts.value.findIndex(
        (data) => data.id === id
      );
      return post_list.posts.value[postIndex];
    });

    return {
      currentUser,
      state,
    };
  },
};
</script>

<style>
</style>