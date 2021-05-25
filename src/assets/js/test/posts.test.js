import { createLocalVue } from "@vue/test-utils";
import storePost from '../stores/posts'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`posts.js`, () => {
  it('get posts', async () => {
    axios.get.mockResolvedValue({ data: [{ id: 1, tweet: 'test' }] });
    const store = storePost()
    await store.getPost();
    expect(store.posts.value[0].tweet).toEqual("test");
  })

  it('delete posts', async () => {
    const store = storePost()
    store.posts.value = [{ id: 1, tweet: 'test' }]
    await store.deletePost(1);
    expect(store.posts.value).toEqual([]);
  })

  it('error in delete posts ', async () => {
    expect.assertions(1);
    try {
      const store = storePost()
      await store.deletePost(100);
      const msg = { response: { data: { errors: { tweet: ["ツイートが存在しません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.tweet[0]).toEqual("ツイートが存在しません");
    }
  });
})