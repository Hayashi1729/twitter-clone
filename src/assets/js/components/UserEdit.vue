<template>
  <user-provider>
    <user-edit-sub />
  </user-provider>
</template>

<script>
import UserEditSub from "./UserEditSub.vue";
import UserProvider from "./UserProvider.vue";
export default {
  components: { UserProvider, UserEditSub },
};
</script>

<style>
</style>