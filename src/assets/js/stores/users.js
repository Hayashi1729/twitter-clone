import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function userStore() {
  const state = reactive({
    users: [],
  })

  async function userGet() {
    const response = await axios.get('/api/users')
    state.users = response.data
  }

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
    userGet,
    userDelete
  }
}
