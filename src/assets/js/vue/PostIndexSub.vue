<template>
  <div>
    <h1>ツイート一覧</h1>

    <table class="postTable">
      <thead>
        <tr>
          <th>Tweet</th>
          <th>投稿者名</th>
          <th>投稿日時</th>

          <th></th>
          <th></th>

          <th width="150">お気に入り数</th>
        </tr>
      </thead>
      <tbody v-for="post in reversePosts" :key="post.id">
        <tr>
          <td>{{ post.tweet }}</td>
          <td>{{ post.user.username }}</td>
          <td>{{ post.inserted_at }}</td>

          <td>
            <a v-bind:href="`/posts/${post.id}`">Show</a>
            <a v-bind:href="`/posts/${post.id}/edit`">Edit</a>
            <button v-on:click="deletePost(post.id)">Delete</button>
          </td>

          <post-index-sub-favorite
            v-bind:post="post"
            v-bind:favorite="postsFavoritedByCurrentUser"
          ></post-index-sub-favorite>
        </tr>
      </tbody>
    </table>

    <a href="/posts/new">新しい投稿</a>
    <br />
    <a href="/">トップページに戻る</a>
  </div>
</template>

<script>
import {
  reactive,
  onMounted,
  computed,
  inject,
  toRefs,
} from "@vue/composition-api";
import axios from "axios";
import PostIndexSubFavorite from "./PostIndexSubFavorite.vue";

export default {
  components: { PostIndexSubFavorite },
  setup() {
    const state = reactive({
      postsFavoritedByCurrentUser: [],
    });

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }
    postList.postGet();

    const getData = async () => {
      const favoritedPost = await axios.get("/api/favorited_post");
      state.postsFavoritedByCurrentUser = favoritedPost.data;
    };

    onMounted(getData);

    const reversePosts = computed(() => {
      return postList.posts.value.slice().reverse();
    });

    function deletePost(id) {
      postList.postDelete(id);
    }

    return {
      postList,
      ...toRefs(state),
      reversePosts,
      deletePost,
    };
  },
};
</script>

<style>
</style>