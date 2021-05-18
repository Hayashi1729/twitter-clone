<template>
  <div>
    <h1>Show Post</h1>

    <ul v-if="currentPost">
      <li>
        <strong>Tweet:</strong>
        {{ currentPost.tweet }}
      </li>

      <li>
        <strong>Username:</strong>
        {{ currentPost.user.username }}
      </li>
    </ul>
    <a v-bind:href="`${currentURL}/edit`">Edit</a>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
import { inject, computed } from "@vue/composition-api";

export default {
  setup() {
    const currentURL = window.location.href;

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }
    postList.postGet();

    const currentPost = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const post = postList.posts.value.find((data) => data.id === id);
      return post;
    });

    return {
      currentPost,
      currentURL,
    };
  },
};
</script>

<style>
</style>