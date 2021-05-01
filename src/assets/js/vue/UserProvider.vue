<template>
  <div>
    <slot />
  </div>
</template>

<script>
const { provide } = VueCompositionAPI;
import userStore from "../stores/users";

export default {
  setup() {
    provide("userList", userStore());

    return {};
  },
};
</script>