import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function storeFavorite() {
  const state = reactive({
    favorites: [],
  })

  async function getFavorite() {
    const response = await axios.get("/api/favorited_post");
    state.favorites = response.data;
  }

  async function createFavorite(post) {
    try {
      await axios.post(`/posts/${post.id}/favorite`, {
        post_id: post.id,
      });
      state.favorites.push(post.id);
    } catch (error) {
      console.error(error);
    }
  }

  async function deleteFavorite(post) {
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
    getFavorite,
    createFavorite,
    deleteFavorite,
  }
}