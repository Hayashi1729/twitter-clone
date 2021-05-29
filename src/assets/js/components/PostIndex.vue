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

          <td>
            <div v-if="isFavorited(post.id)">
              <button v-on:click="deleteFavorite(post)">
                お気に入り登録を解除する
              </button>
            </div>
            <div v-else>
              <button v-on:click="createFavorite(post)">
                お気に入り登録する
              </button>
            </div>
          </td>
          <td>{{ post.favorites.length }}</td>
        </tr>
      </tbody>
    </table>

    <a href="/posts/new">新しい投稿</a>
    <br />
    <a href="/">トップページに戻る</a>
  </div>
</template>

<script>
import { computed, onMounted } from "@vue/composition-api";
import { usePostListStore } from "./postKey";
import { useFavoriteListStore } from "./favoriteKey";

export default {
  setup() {
    const postList = usePostListStore();
    const favoriteList = useFavoriteListStore();

    onMounted(() => {
      postList.getPost();
      favoriteList.getFavorite();
    });

    const reversePosts = computed(() => {
      return postList.posts.value.slice().reverse();
    });

    function deletePost(id) {
      postList.deletePost(id);
    }

    async function createFavorite(post) {
      await favoriteList.createFavorite(post);
      await postList.getPost();
    }

    async function deleteFavorite(post) {
      await favoriteList.deleteFavorite(post);
      await postList.getPost();
    }

    function isFavorited(id) {
      return favoriteList.favorites.value.includes(id);
    }

    return {
      postList,
      favoriteList,
      reversePosts,
      deletePost,
      createFavorite,
      deleteFavorite,
      isFavorited,
    };
  },
};
</script>

<style>
</style>