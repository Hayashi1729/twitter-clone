<template>
  <div v-if="currentUser">
    <h1>Show User</h1>

    <ul>
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
const { reactive, inject, computed, toRefs } = VueCompositionAPI;

export default {
  setup() {
    const state = reactive({
      currentURL: window.location.href,
    });

    const userList = inject("userList");
    if (!userList) {
      throw new Error(`userList is not provided`);
    }

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