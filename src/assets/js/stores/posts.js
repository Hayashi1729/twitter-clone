import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function postStore() {
  const state = reactive({
    posts: [],
  })

  async function postGet() {
    const response = await axios.get('/api/posts')
    state.posts = response.data
  }

  async function postDelete(id) {
    try {
      const response = await axios.delete(`/api/posts/${id}`);
      state.posts = state.posts.filter((post) => post.id !== id);
    } catch (error) {
      console.error(error);
    }
  }

  return {
    ...toRefs(state),
    postGet,
    postDelete
  }
}

