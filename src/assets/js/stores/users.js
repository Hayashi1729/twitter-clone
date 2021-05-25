import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function storeUser() {
  const state = reactive({
    users: [],
  })

  async function getUser() {
    const response = await axios.get('/api/users')
    state.users = response.data
  }

  async function deleteUser(id) {
    try {
      await axios.delete(`/api/users/${id}`);
      state.users = state.users.filter((user) => user.id !== id);
    } catch (error) {
      console.error(error);
    }
  }

  return {
    ...toRefs(state),
    getUser,
    deleteUser
  }
}
