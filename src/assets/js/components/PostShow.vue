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
import { computed } from "@vue/composition-api";
import { setupPostList } from "./postKey";

export default {
  setup() {
    const postList = setupPostList();

    const currentURL = window.location.href;

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