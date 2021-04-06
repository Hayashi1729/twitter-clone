<template>
  <div>
    <h1>ツイート一覧</h1>

    <table>
      <thead>
        <tr>
          <th>Tweet</th>
          <th>投稿者名</th>
          <th>投稿日時</th>

          <th></th>
          <th></th>

          <th>お気に入り数</th>
        </tr>
      </thead>
      <tbody>
        <div v-for="post in reversePosts" :key="post.id">
          <tr>
            <td>{{ post.tweet }}</td>
            <td>{{ post.user.username }}</td>
            <td>{{ post.inserted_at }}</td>

            <td>
              <a v-bind:href="'posts/' + post.id">Show</a>
              <a v-bind:href="'posts/' + post.id + '/edit'">Edit</a>
              <button v-on:click="deletePost(post.id)">Delete</button>
            </td>

            <td>
              <div v-if="posts_favorited_by_current_user.includes(post.id)">
                <a
                  v-bind:href="'posts/' + post.id + '/favorite'"
                  v-on:click="deleteFavorite(post.id)"
                  data-method="DELETE"
                >
                  お気に入り登録を解除する
                </a>
              </div>
              <div v-else>
                <button v-on:click="createFavorite(post.id)">
                  お気に入り登録する
                </button>
              </div>
            </td>
            <td>{{ post.favorites.length }}</td>
          </tr>
        </div>
      </tbody>
    </table>

    <a href="posts/new">新しい投稿</a>
  </div>
</template>

<script>
export default {
  data() {
    return {
      posts: [],
      posts_favorited_by_current_user: [],
    };
  },
  created: function () {
    axios.get("../api/posts").then((response) => {
      this.posts = response.data;
    });
    axios.get("../api/favorited_post").then((response) => {
      this.posts_favorited_by_current_user = response.data;
    });
  },
  computed: {
    reversePosts() {
      return this.posts.slice().reverse();
    },
  },
  methods: {
    deletePost: function (id) {
      axios.delete("../api/posts/" + id);

      axios.get("../api/posts").then((response) => {
        this.posts = response.data;
      });
    },
    createFavorite: function (id) {
      axios.post("posts/" + post.id + "/favorite");
    },
    deleteFavorite: function (id) {
      axios.delete("posts/" + post.id + "/favorite");
    },
  },
};
</script>

<style>
</style>