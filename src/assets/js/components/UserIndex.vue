<template>
  <user-provider>
    <user-index-sub />
  </user-provider>
</template>

<script>
import UserIndexSub from "./UserIndexSub.vue";
import UserProvider from "./UserProvider.vue";
export default {
  components: { UserProvider, UserIndexSub },
};
</script>

<style>
</style>