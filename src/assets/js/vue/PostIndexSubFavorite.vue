<template>
  <div>
    <td>
      <div v-if="isFavorited(post.id)">
        <button v-on:click="deleteFavorite(post)">
          お気に入り登録を解除する
        </button>
      </div>
      <div v-else>
        <button v-on:click="createFavorite(post)">お気に入り登録する</button>
      </div>
    </td>
    <td>{{ numberOfFavorites }}</td>
  </div>
</template>

<script>
import { reactive, toRefs } from "@vue/composition-api";
import axios from "axios";

export default {
  props: ["post", "favorite"],
  setup(props) {
    const state = reactive({
      numberOfFavorites: props.post.favorites.length,
    });
    async function createFavorite(post) {
      try {
        await axios.post(`/favorite`, {
          post_id: post.id,
        });
        props.favorite.push(post.id);
        state.numberOfFavorites++;
      } catch (error) {
        console.error(error);
      }
    }

    async function deleteFavorite(post) {
      try {
        await axios.delete(`/favorite`, {
          data: { post_id: post.id },
        });
        props.favorite = props.favorite.filter(
          (favoriteId) => favoriteId !== post.id
        );
        state.numberOfFavorites--;
      } catch (error) {
        console.error(error);
      }
    }

    function isFavorited(id) {
      return props.favorite.includes(id);
    }
    return {
      ...toRefs(state),
      createFavorite,
      deleteFavorite,
      isFavorited,
    };
  },
};
</script>

<style>
</style>