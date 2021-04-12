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
              <a v-bind:href="'/posts/' + post.id">Show</a>
              <a v-bind:href="'/posts/' + post.id + '/edit'">Edit</a>
              <button v-on:click="deletePost(post.id)">Delete</button>
            </td>

            <td>
              <div v-if="posts_favorited_by_current_user.includes(post.id)">
                <button v-on:click="deleteFavorite(post.id)">
                  お気に入り登録を解除する
                </button>
              </div>
              <div v-else>
                <button v-on:click="createFavorite(post.id)">
                  お気に入り登録する
                </button>
              </div>
            </td>
            <td>{{ favorite_num }}</td>
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
      favorites: [],
      fav_num: 0,
    };
  },
  created: function () {
    axios.get("/api/posts").then((response) => {
      this.posts = response.data;
    });
    axios.get("/api/favorited_post").then((response) => {
      this.posts_favorited_by_current_user = response.data;
    });
    axios.get("/api/favorites").then((response) => {
      this.favorites = response.data;
    });
  },
  computed: {
    reversePosts() {
      return this.posts.slice().reverse();
    },
    favorite_num() {
      if (this.post.favorites && this.post.favorites.length > 1) {
        return this.post.favorites.length;
      }
    },
  },
  watch: {
    post: {
      handler: function () {
        console.log("caught!");
      },
      deep: true,
    },
  },
  methods: {
    async deletePost(id) {
      try {
        const response = await axios.delete("/api/posts/" + id);
        this.posts = this.posts.filter((post) => post.id !== id);
      } catch (error) {
        console.error(error);
      }
    },
    async createFavorite(id) {
      try {
        const response = await axios.post("posts/" + id + "/favorite");
        this.fav_num += 1;
        this.posts_favorited_by_current_user.push(id);
      } catch (error) {
        console.error(error);
      }
    },
    async deleteFavorite(id) {
      try {
        const response = await axios.delete("posts/" + id + "/favorite");
        this.fav_num -= 1;
        this.posts_favorited_by_current_user = this.posts_favorited_by_current_user.filter(
          (favorite_id) => favorite_id !== id
        );
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style>
</style>