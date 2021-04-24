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
            <div v-if="is_favorited(post.id)">
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

    <a href="posts/new">新しい投稿</a>
  </div>
</template>

<script>
const { reactive, onMounted, computed } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      posts: [],
      posts_favorited_by_current_user: [],
      favorites: [],
    });
    const getData = async () => {
      const posts = await axios.get("/api/posts");
      state.posts = posts.data;

      const favorited_post = await axios.get("/api/favorited_post");
      state.posts_favorited_by_current_user = favorited_post.data;

      const favorites = await axios.get("/api/favorites");
      state.favorites = favorites.data;
    };

    onMounted(getData);

    const reversePosts = computed(() => {
      return state.posts.slice().reverse();
    });

    async function deletePost(id) {
      try {
        const response = await axios.delete(`/api/posts/${id}`);
        state.posts = state.posts.filter((post) => post.id !== id);
      } catch (error) {
        console.error(error);
      }
    }

    async function createFavorite(post) {
      try {
        const response = await axios.post(`posts/${post.id}/favorite`);
        state.posts_favorited_by_current_user.push(post.id);
        post.favorites.push(1);
      } catch (error) {
        console.error(error);
      }
    }

    async function deleteFavorite(post) {
      try {
        const response = await axios.delete(`posts/${post.id}/favorite`);
        state.posts_favorited_by_current_user = state.posts_favorited_by_current_user.filter(
          (favorite_id) => favorite_id !== post.id
        );
        post.favorites.pop();
      } catch (error) {
        console.error(error);
      }
    }

    function countFavorites(post) {
      return post.favorites.length;
    }

    function is_favorited(id) {
      return state.posts_favorited_by_current_user.includes(id);
    }

    return {
      state,
      reversePosts,
      deletePost,
      createFavorite,
      deleteFavorite,
      countFavorites,
      is_favorited,
    };
  },
};
</script>

<style>
</style>