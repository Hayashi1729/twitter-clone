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
import { inject, computed } from "@vue/composition-api";

export default {
  setup() {
    const currentURL = window.location.href;

    const userList = inject("userList");
    if (!userList) {
      throw new Error(`userList is not provided`);
    }
    userList.getUser();

    const currentUser = computed(() => {
      const id = parseInt(window.location.pathname.split("/")[2]);
      const user = userList.users.value.find((data) => data.id === id);
      return user;
    });

    return {
      currentUser,
      currentURL,
    };
  },
};
</script>

<style>
</style>