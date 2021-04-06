<template>
  <div>
    <h1>Show User</h1>

    <ul>
      <li>
        <strong>Username:</strong>
        {{ user.username }}
      </li>
    </ul>
    <a v-bind:href="currentURL + '/edit'">Edit</a>
    <a href="../users">Back</a>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: [],
      currentURL: window.location.href,
    };
  },
  created: function () {
    axios.get("../api/" + window.location.pathname).then((response) => {
      this.user = response.data;
    });
  },
};
</script>

<style>
</style>