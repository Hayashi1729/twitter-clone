<template>
  <div>
    <h1>Login</h1>

    <label for="username">Username</label>
    <input type="text" id="username" v-model="username" />
    <p v-if="errors.username" style="color: red">
      {{ errors.username[0] }}
    </p>

    <label for="password">Password</label>
    <input type="password" id="password" v-model="password" />
    <p v-if="errors.password" style="color: red">
      {{ errors.password[0] }}
    </p>

    <button type="submit" v-on:click="createSession" action="/">Log in</button>
    <a href="/">トップページに戻る</a>
  </div>
</template>


<script>
import { reactive, toRefs } from "@vue/composition-api";
import axios from "axios";

export default {
  setup() {
    const state = reactive({
      username: "",
      password: "",
      errors: {},
    });

    async function createSession() {
      try {
        await axios.post("/sessions", {
          session: {
            username: state.username,
            password: state.password,
          },
        });
        window.location.href = "/";
      } catch (error) {
        console.error(error);
        if (error.response.data && error.response.data.errors) {
          state.errors = error.response.data.errors;
        }
      }
    }

    return {
      ...toRefs(state),
      createSession,
    };
  },
};
</script>

<style>
</style>