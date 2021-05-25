<template>
  <post-provider>
    <post-edit-sub />
  </post-provider>
</template>

<script>
import PostEditSub from "./PostEditSub.vue";
import PostProvider from "./PostProvider.vue";
export default {
  components: { PostProvider, PostEditSub },
};
</script>

<style>
</style>