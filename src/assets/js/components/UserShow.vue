<template>
  <user-provider>
    <user-show-sub />
  </user-provider>
</template>

<script>
import UserShowSub from "./UserShowSub.vue";
import UserProvider from "./UserProvider.vue";
export default {
  components: { UserProvider, UserShowSub },
};
</script>

<style>
</style>