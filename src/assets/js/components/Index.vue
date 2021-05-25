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
import { ref, defineComponent } from "@vue/composition-api";

export default defineComponent({
  name: "Index",
  setup() {
    const test = "test";
    const message = ref("Twitter");

    return {
      test,
      message,
    };
  },
});
</script>
