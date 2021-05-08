<template>
  <div>
    <h1>Show User</h1>

    <ul v-if="currentUser">
      <li>
        <strong>Username:</strong>
        {{ currentUser.username }}
      </li>
    </ul>
    <a v-bind:href="`${currentURL}/edit`">Edit</a>
    <a href="/users">Back</a>
  </div>
</template>

<script>
import { reactive, inject, computed, toRefs } from "@vue/composition-api";

export default {
  setup() {
    const state = reactive({
      currentURL: window.location.href,
    });

    const userList = inject("userList");
    if (!userList) {
      throw new Error(`userList is not provided`);
    }
    userList.userGet();

    const currentUser = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const userIndex = userList.users.value.findIndex(
        (data) => data.id === id
      );
      return userList.users.value[userIndex];
    });

    return {
      currentUser,
      ...toRefs(state),
    };
  },
};
</script>

<style>
</style>