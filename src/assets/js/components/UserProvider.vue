<template>
  <div>
    <slot />
  </div>
</template>

<script>
import { provide } from "@vue/composition-api";
import storeUser from "../stores/users";

export default {
  setup() {
    provide("userList", storeUser());

    return {};
  },
};
</script>