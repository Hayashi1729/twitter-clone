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
              <span>Show</span>
              <span>Edit</span>
              <button v-on:click="deletePost(post.id)">Delete</button>
            </td>

            <td>
              <div v-if="posts_favorited_by_current_user.includes(post.id)">
                <span>お気に入り登録を解除する</span>
              </div>
              <div v-else>
                <span>お気に入り登録する</span>
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
  method: {
    deletePost(id) {
      axios.delete("/posts/" + id);

      axios.get("api/posts").then((response) => {
        this.posts = response.data;
      });
    },
  },
};
</script>

<style>
</style>