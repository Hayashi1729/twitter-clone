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

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }

    const currentUser = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const postIndex = postList.posts.value.findIndex(
        (data) => data.id === id
      );
      return postList.posts.value[postIndex];
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