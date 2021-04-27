<template>
  <post-provider>
    <post-index-sub />
  </post-provider>
</template>

<script>
import PostIndexSub from "./PostIndexSub.vue";
import PostProvider from "./PostProvider.vue";
export default {
  components: { PostProvider, PostIndexSub },
};
</script>

<style>
</style>