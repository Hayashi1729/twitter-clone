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
    provide("user_list", userStore());

    return {};
  },
};
</script>