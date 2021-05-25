<template>
  <favorite-provider>
    <post-provider>
      <post-index-sub />
    </post-provider>
  </favorite-provider>
</template>

<script>
import PostIndexSub from "./PostIndexSub.vue";
import PostProvider from "./PostProvider.vue";
import FavoriteProvider from "./FavoriteProvider.vue";
export default {
  components: { FavoriteProvider, PostProvider, PostIndexSub },
};
</script>

<style>
</style>