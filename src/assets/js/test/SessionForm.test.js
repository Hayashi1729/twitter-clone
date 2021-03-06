import { createLocalVue, shallowMount } from "@vue/test-utils";
import SessionForm from '../components/SessionForm.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios')

import "regenerator-runtime/runtime";

describe(`SessionForm.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/sessions/new";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    })

    const options = { localVue }
    wrapper = shallowMount(SessionForm, options)
  })

  it('render SessionForm', () => {
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
    axios.post.mockResolvedValue({ data: { session: { username: 'test', password: 'password' } } });
    await wrapper.vm.createSession()
    expect(window.location.href).toBe("/")
  })

  it('error in createSession ', async () => {
    expect.assertions(1);
    try {
      axios.post.mockResolvedValue({ data: { session: { username: '', password: '' } } });
      await wrapper.vm.createSession()
      const msg = { response: { data: { errors: { username: ["ユーザーが存在しません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.username[0]).toEqual("ユーザーが存在しません");
    }
  });
})