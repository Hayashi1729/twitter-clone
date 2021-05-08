import { createLocalVue, shallowMount } from "@vue/test-utils";
import SessionNew from '../vue/SessionNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

axios.post.mockResolvedValue({ data: { users: [{ id: 1, username: 'test', password: 'password' }] } });

describe(`SessionNew.vue`, () => {
  const options = { localVue }
  const wrapper = shallowMount(SessionNew, options)

  it('render SessionNew', () => {
    expect(wrapper.html()).toContain('Login')
  })

  it('set username and password', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_name')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_name')

    const passwordInput = wrapper.find('input[type="password"]')
    await passwordInput.setValue('password')

    expect(wrapper.find('input[type="password"]').element.value).toBe('password')
  })

  it('createSession', async () => {
    console.log(wrapper.vm.createSession)
    await wrapper.vm.createSession()
  })
})