import { createLocalVue } from "@vue/test-utils";
import storeFavorite from '../stores/favorites'
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
    const store = storeFavorite()
    await store.getFavorite();
    const response = store.favorites.value
    expect(response).toEqual([1, 2]);
  })

  it('create favorite', async () => {
    const store = storeFavorite()
    const post = { id: 100, tweet: 'test' }
    await store.createFavorite(post)
    expect(store.favorites.value).toEqual([100]);
  })

  it('delete favorite', async () => {
    const store = storeFavorite()
    store.favorites.value = [1, 2]

    const post = { id: 1, tweet: 'test' }
    await store.deleteFavorite(post)
    expect(store.favorites.value).toEqual([2]);
  })

  it('error in create favorite ', async () => {
    expect.assertions(1);
    try {
      const store = storeFavorite()
      const post = { id: 1, tweet: 'test' }
      await store.createFavorite(post);
      const msg = { response: { data: { errors: { favorite: ["このツイートはすでにお気に入り登録されています。"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはすでにお気に入り登録されています。");
    }
  });

  it('error in delete favorite ', async () => {
    expect.assertions(1);
    try {
      const store = storeFavorite()
      const post = { id: 200, tweet: 'test' }
      await store.deleteFavorite(post);
      const msg = { response: { data: { errors: { favorite: ["このツイートはお気に入り登録されていません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはお気に入り登録されていません");
    }
  });
})