<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import storePost from "../stores/posts";

export default {
  setup() {
    provide("postList", storePost());

    return {};
  },
};
</script>