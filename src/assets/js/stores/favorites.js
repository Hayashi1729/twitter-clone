import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function favoriteStore() {
  const state = reactive({
    favorites: [],
  })

  async function favoriteGet() {
    const response = await axios.get("/api/favorited_post");
    state.favorites = response.data;
  }
  async function favoriteCreate(post) {
    try {
      await axios.post(`/posts/${post.id}/favorite`, {
        post_id: post.id,
      });
      state.favorites.push(post.id);
    } catch (error) {
      console.error(error);
    }
  }
  async function favoriteDelete(post) {
    try {
      await axios.delete(`/posts/${post.id}/favorite`, {
        data: { post_id: post.id },
      });
      state.favorites = state.favorites.filter(
        (favoriteId) => favoriteId !== post.id
      );
    } catch (error) {
      console.error(error);
    }
  }

  return {
    ...toRefs(state),
    favoriteGet,
    favoriteCreate,
    favoriteDelete,
  }
}