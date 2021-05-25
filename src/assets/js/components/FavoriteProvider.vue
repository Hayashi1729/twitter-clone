<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import storeFavorite from "../stores/favorites";

export default {
  setup() {
    provide("favoriteList", storeFavorite());

    return {};
  },
};
</script>