<template>
  <div>
    <section class="phx-hero">
      <h1>Welcome to {{ message }}!</h1>
      <a href="/users/new">アカウント作成</a>
      <br />
      <a href="/posts">タイムライン表示</a>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Twitter",
    };
  },
};
</script>
