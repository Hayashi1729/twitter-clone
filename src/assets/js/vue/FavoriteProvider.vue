<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import favoriteStore from "../stores/favorites";

export default {
  setup() {
    provide("favoriteList", favoriteStore());

    return {};
  },
};
</script>