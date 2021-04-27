<template>
  <post-provider>
    <post-show-sub />
  </post-provider>
</template>

<script>
import PostShowSub from "./PostShowSub.vue";
import PostProvider from "./PostProvider.vue";
export default {
  components: { PostProvider, PostShowSub },
};
</script>

<style>
</style>