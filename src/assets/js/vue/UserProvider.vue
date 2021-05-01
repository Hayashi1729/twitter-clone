<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import userStore from "../stores/users";

export default {
  setup() {
    provide("userList", userStore());

    return {};
  },
};
</script>