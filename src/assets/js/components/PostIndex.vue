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

          <post-index-favorite
            v-bind:post="post"
            v-bind:favorite="favoriteList.favorites.value"
            v-on:create="pushFavorite"
            v-on:delete="filterFavorite"
          ></post-index-favorite>
        </tr>
      </tbody>
    </table>

    <a href="/posts/new">新しい投稿</a>
    <br />
    <a href="/">トップページに戻る</a>
  </div>
</template>

<script>
import { computed } from "@vue/composition-api";
import PostIndexFavorite from "./PostIndexFavorite.vue";
import { setupPostList } from "./postKey";
import { setupFavoriteList } from "./favoriteKey";

export default {
  components: { PostIndexFavorite },
  setup() {
    const postList = setupPostList();

    const favoriteList = setupFavoriteList();

    const reversePosts = computed(() => {
      return postList.posts.value.slice().reverse();
    });

    function deletePost(id) {
      postList.deletePost(id);
    }

    function pushFavorite(post) {
      favoriteList.createFavorite(post);
    }

    function filterFavorite(post) {
      favoriteList.deleteFavorite(post);
    }

    return {
      postList,
      favoriteList,
      reversePosts,
      deletePost,
      pushFavorite,
      filterFavorite,
    };
  },
};
</script>

<style>
</style>