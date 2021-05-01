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
          <td>{{ countFavorites(post) }}</td>
        </tr>
      </tbody>
    </table>

    <a href="/posts/new">新しい投稿</a>
    <br />
    <a href="/">トップページに戻る</a>
  </div>
</template>

<script>
const { reactive, onMounted, computed, inject } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      postsFavoritedByCurrentUser: [],
      favorites: [],
    });

    const postList = inject("postList");
    if (!postList) {
      throw new Error(`postList is not provided`);
    }

    const getData = async () => {
      const favoritedPost = await axios.get("/api/favorited_post");
      state.postsFavoritedByCurrentUser = favoritedPost.data;

      const favorites = await axios.get("/api/favorites");
      state.favorites = favorites.data;
    };

    onMounted(getData);

    const reversePosts = computed(() => {
      return postList.posts.value.slice().reverse();
    });

    function deletePost(id) {
      postList.postDelete(id);
    }

    async function createFavorite(post) {
      try {
        const response = await axios.post(`posts/${post.id}/favorite`);
        state.postsFavoritedByCurrentUser.push(post.id);
        post.favorites.push(1);
      } catch (error) {
        console.error(error);
      }
    }

    async function deleteFavorite(post) {
      try {
        const response = await axios.delete(`posts/${post.id}/favorite`);
        state.postsFavoritedByCurrentUser = state.postsFavoritedByCurrentUser.filter(
          (favoriteId) => favoriteId !== post.id
        );
        post.favorites.pop();
      } catch (error) {
        console.error(error);
      }
    }

    function countFavorites(post) {
      return post.favorites.length;
    }

    function isFavorited(id) {
      return state.postsFavoritedByCurrentUser.includes(id);
    }

    return {
      postList,
      state,
      reversePosts,
      deletePost,
      createFavorite,
      deleteFavorite,
      countFavorites,
      isFavorited,
    };
  },
};
</script>

<style>
</style>