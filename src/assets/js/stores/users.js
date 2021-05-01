import { reactive, toRefs } from "@vue/composition-api";

export default function userStore() {
  const state = reactive({
    users: [],
  })

  axios.get('/api/users').then(response => {
    state.users = response.data
  })

  async function userDelete(id) {
    try {
      const response = await axios.delete(`/api/users/${id}`);
      state.users = state.users.filter((user) => user.id !== id);
    } catch (error) {
      console.error(error);
    }
  }

  return {
    ...toRefs(state),
    userDelete
  }
}
