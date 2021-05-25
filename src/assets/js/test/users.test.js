import { createLocalVue } from "@vue/test-utils";
import storeUser from '../stores/users'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

describe(`users.js`, () => {
  it('get users', async () => {
    axios.get.mockResolvedValue({ data: [{ id: 1, username: 'test' }] });
    const store = storeUser()
    await store.getUser();
    const response = store.users.value[0].username
    expect(response).toEqual("test");
  })

  it('delete users', async () => {
    const store = storeUser()
    store.users.value = [{ id: 1, username: 'test' }]
    await store.deleteUser(1)
    expect(store.users.value).toEqual([]);
  })

  it('error in delete users ', async () => {
    expect.assertions(1);
    try {
      const store = storeUser()
      await store.deleteUser(100);
      const msg = { response: { data: { errors: { username: ["ユーザーが存在しません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.username[0]).toEqual("ユーザーが存在しません");
    }
  });
})