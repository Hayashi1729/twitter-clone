<template>
  <div>
    {{ message }}
    <div v-for="user in users" :key="user.id">
      <pre>{{ user.username }}</pre>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello",
      users: [],
    };
  },
  created: function () {
    axios.get("api/users").then((response) => {
      this.users = response.data;
    });
  },
};
</script>
