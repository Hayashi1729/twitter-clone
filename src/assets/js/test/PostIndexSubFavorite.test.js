import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndexSubFavorite from '../components/PostIndexSubFavorite.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`PostIndexSubFavorite.vue`, () => {
  const wrapper = shallowMount(PostIndexSubFavorite, {
    propsData: {
      post: { id: 1, tweet: 'test', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 1 }] },
      favorite: [1]
    },
    localVue
  })

  beforeAll(() => {
    axios.get.mockResolvedValue({ data: [1] })
    axios.post.mockResolvedValue({})
    axios.delete.mockResolvedValue({})
  })

  it('isFavorited', () => {
    expect(wrapper.vm.isFavorited(1)).toBeTruthy()
  })

  it("createFavorite", async () => {
    const post = { id: 100, favorites: [{ user_id: 1, post_id: 1 }] }
    await wrapper.vm.createFavorite(post)
    expect(wrapper.vm.numberOfFavorites).toBe(2)
  })

  it("deleteFavorite", async () => {
    await wrapper.vm.deleteFavorite(wrapper.props().post)
    expect(wrapper.vm.numberOfFavorites).toBe(1)
  })

  it('error in createFavorite ', async () => {
    expect.assertions(1);
    try {
      const post = { id: 100, favorites: [{ user_id: 1, post_id: 1 }] }
      await wrapper.vm.createFavorite(post)
      const msg = { response: { data: { errors: { user_id: ["このツイートはすでにお気に入り登録されています。"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.user_id[0]).toEqual("このツイートはすでにお気に入り登録されています。");
    }
  });

  it('error in deleteFavorite ', async () => {
    expect.assertions(1);
    try {
      await wrapper.vm.deleteFavorite({ id: 2 })
      const msg = { response: { data: { errors: { favorite: ["このツイートはお気に入り登録されていません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはお気に入り登録されていません");
    }
  });
})
