<template>
  <div>
    <h1>Edit Post</h1>
    <label for="post">Tweet</label>

    <input type="text" id="post" v-model="currentPostTweet" />
    <p v-if="errors.tweet" style="color: red">
      {{ errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="editPost(postId)">Save</button>
    <a href="/posts">Back</a>
  </div>
</template>

<script>
import { reactive, inject, toRefs, computed } from "@vue/composition-api";
import axios from "axios";

export default {
  setup() {
    const state = reactive({
      errors: {},
    });

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }
    postList.postGet();

    const postId = parseInt(window.location.pathname.split("/")[2]);

    const currentPost = computed(() => {
      const post = postList.posts.value.find((data) => data.id === postId);

      return post;
    });

    const currentPostTweet = computed({
      get: () => {
        if (currentPost.value) {
          return currentPost.value.tweet;
        } else {
          return "";
        }
      },
      set: (value) => {
        currentPost.value.tweet = value;
      },
    });

    async function editPost(id) {
      try {
        await axios.put(`/api/posts/${id}`, {
          id: id,
          post: {
            tweet: currentPostTweet.value,
          },
        });
        window.location.href = "/posts";
      } catch (error) {
        console.error(error);
        if (error.response.data && error.response.data.errors) {
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