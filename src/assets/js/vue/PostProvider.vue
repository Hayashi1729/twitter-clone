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
    provide("post_list", postStore());

    return {};
  },
};
</script>