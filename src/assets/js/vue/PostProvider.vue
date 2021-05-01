<template>
  <div>
    <slot />
  </div>
</template>

<script>
const { provide } = VueCompositionAPI;
import postStore from "../stores/posts";

export default {
  setup() {
    provide("postList", postStore());

    return {};
  },
};
</script>