import { createLocalVue, shallowMount } from "@vue/test-utils";
import postStore from '../stores/posts'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

axios.get.mockResolvedValue({ data: { posts: [{ id: 1, tweet: 'test' }] } });

describe(`posts.js`, () => {
  const options = { localVue }

  it('get posts', async () => {
    const store = postStore()
    await store.postGet();
    const response = store.posts.value.posts[0].tweet
    expect(response).toEqual("test");
  })

  it('delete posts', async () => {
    const store = postStore()
    await store.postDelete(1)

    const response = store.posts.value
    expect(response).toEqual([]);
  })
})