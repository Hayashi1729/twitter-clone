import { createLocalVue, shallowMount } from "@vue/test-utils";
import userStore from '../stores/users'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

axios.get.mockResolvedValue({ data: { users: [{ id: 1, username: 'test' }] } });

describe(`users.js`, () => {
  const options = { localVue }

  it('get users', async () => {
    const store = userStore()
    await store.userGet();
    const response = store.users.value.users[0].username
    expect(response).toEqual("test");
  })

  it('delete users', async () => {
    const store = userStore()
    await store.userDelete(1)

    const response = store.users.value
    expect(response).toEqual([]);
  })
})