<template>
  <div>
    <h1>New Post</h1>

    <label for="tweet">Tweet</label>
    <input type="text" id="tweet" v-model="tweet" />
    <p v-if="errors.tweet" style="color: red">
      {{ errors.tweet[0] }}
    </p>

    <button type="submit" v-on:click="createPost">Save</button>

    <a href="/posts">Back</a>
  </div>
</template>

<script>
import { reactive, toRefs } from "@vue/composition-api";
import axios from "axios";

export default {
  setup() {
    const state = reactive({
      tweet: "",
      errors: {},
    });

    async function createPost() {
      try {
        await axios.post("/api/posts", {
          post: { tweet: state.tweet },
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
      createPost,
    };
  },
};
</script>

<style>
</style>