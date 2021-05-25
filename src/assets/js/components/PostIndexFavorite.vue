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

export default {
  props: ["post", "favorite"],
  setup(props, { emit }) {
    const state = reactive({
      numberOfFavorites: props.post.favorites.length,
    });

    function createFavorite(post) {
      emit("create", post);
      state.numberOfFavorites++;
    }

    function deleteFavorite(post) {
      emit("delete", post);
      state.numberOfFavorites--;
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