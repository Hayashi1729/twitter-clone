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
    <td>{{ fav_num }}</td>
  </div>
</template>

<script>
import { reactive, toRefs } from "@vue/composition-api";
import axios from "axios";

export default {
  props: ["post", "fav"],
  setup(props) {
    const state = reactive({
      fav_num: props.post.favorites.length,
    });
    async function createFavorite(post) {
      try {
        const response = await axios.post(`posts/${post.id}/favorite`);
        props.fav.push(post.id);
        state.fav_num++;
      } catch (error) {
        console.error(error);
      }
    }

    async function deleteFavorite(post) {
      try {
        const response = await axios.delete(`posts/${post.id}/favorite`);
        props.fav = props.fav.filter((favoriteId) => favoriteId !== post.id);
        state.fav_num--;
      } catch (error) {
        console.error(error);
      }
    }

    function isFavorited(id) {
      return props.fav.includes(id);
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