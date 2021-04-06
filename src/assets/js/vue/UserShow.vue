<template>
  <div>
    <h1>Show User</h1>

    <ul>
      <li>
        <strong>Username:</strong>
        {{ user.username }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: [],
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