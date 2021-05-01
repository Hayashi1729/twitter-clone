<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import postStore from "../stores/posts";

export default {
  setup() {
    provide("postList", postStore());

    return {};
  },
};
</script>