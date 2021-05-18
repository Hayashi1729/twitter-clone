import { createLocalVue, shallowMount } from "@vue/test-utils";
import userStore from '../stores/users'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`users.js`, () => {
  const options = { localVue }

  it('get users', async () => {
    axios.get.mockResolvedValue({ data: [{ id: 1, username: 'test' }] });
    const store = userStore()
    await store.userGet();
    const response = store.users.value[0].username
    expect(response).toEqual("test");
  })

  it('delete users', async () => {
    const store = userStore()
    store.users.value = [{ id: 1, username: 'test' }]
    await store.userDelete(1)
    expect(store.users.value).toEqual([]);
  })

  it('error in delete users ', async () => {
    expect.assertions(1);
    try {
      const store = userStore()
      await store.userDelete(100);
      const msg = { response: { data: { errors: { username: ["ユーザーが存在しません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.username[0]).toEqual("ユーザーが存在しません");
    }
  });
})