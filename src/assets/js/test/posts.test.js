import { createLocalVue, shallowMount } from "@vue/test-utils";
import postStore from '../stores/posts'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`posts.js`, () => {
  const options = { localVue }

  it('get posts', async () => {
    axios.get.mockResolvedValue({ data: [{ id: 1, tweet: 'test' }] });
    const store = postStore()
    await store.postGet();
    expect(store.posts.value[0].tweet).toEqual("test");
  })

  it('delete posts', async () => {
    const store = postStore()
    store.posts.value = [{ id: 1, tweet: 'test' }]
    await store.postDelete(1);
    expect(store.posts.value).toEqual([]);
  })

  it('error in delete posts ', async () => {
    expect.assertions(1);
    try {
      const store = postStore()
      await store.postDelete(100);
      const msg = { response: { data: { errors: { tweet: ["ツイートが存在しません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.tweet[0]).toEqual("ツイートが存在しません");
    }
  });
})