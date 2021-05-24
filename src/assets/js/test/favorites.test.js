import { createLocalVue } from "@vue/test-utils";
import favoriteStore from '../stores/favorites'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`favorite.js`, () => {
  beforeEach(() => {
    axios.get.mockResolvedValue({ data: [1, 2] });
  })

  it('get favorite', async () => {
    const store = favoriteStore()
    await store.favoriteGet();
    const response = store.favorites.value
    expect(response).toEqual([1, 2]);
  })

  it('create favorite', async () => {
    const store = favoriteStore()
    const post = { id: 100, tweet: 'test' }
    await store.favoriteCreate(post)
    expect(store.favorites.value).toEqual([100]);
  })

  it('delete favorite', async () => {
    const store = favoriteStore()
    store.favorites.value = [1, 2]

    const post = { id: 1, tweet: 'test' }
    await store.favoriteDelete(post)
    expect(store.favorites.value).toEqual([2]);
  })

  it('error in create favorite ', async () => {
    expect.assertions(1);
    try {
      const store = favoriteStore()
      const post = { id: 1, tweet: 'test' }
      await store.favoriteCreate(post);
      const msg = { response: { data: { errors: { favorite: ["このツイートはすでにお気に入り登録されています。"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはすでにお気に入り登録されています。");
    }
  });

  it('error in delete favorite ', async () => {
    expect.assertions(1);
    try {
      const store = favoriteStore()
      const post = { id: 200, tweet: 'test' }
      await store.favoriteDelete(post);
      const msg = { response: { data: { errors: { favorite: ["このツイートはお気に入り登録されていません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはお気に入り登録されていません");
    }
  });
})