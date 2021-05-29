import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserNew from '../components/UserNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios')

import "regenerator-runtime/runtime";

describe(`UserNew.vue`, () => {
  let wrapper;
  beforeAll(() => {
    const pathname = "/users/new";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    })

    const options = { localVue }
    wrapper = shallowMount(UserNew, options)
  })

  it('render UserNew', () => {
    expect(wrapper.html()).toContain('New User')
  })

  it('set username and password', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_name')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_name')

    const passwordInput = wrapper.find('input[type="password"]')
    await passwordInput.setValue('password')

    expect(wrapper.find('input[type="password"]').element.value).toBe('password')
  })

  it('createUser', async () => {
    axios.post.mockResolvedValue({ data: { user: { username: 'test', password: 'password' } } });
    await wrapper.vm.createUser()
    expect(window.location.href).toBe("/users")
  })

  it('error in createUser ', async () => {
    expect.assertions(2);
    try {
      axios.post.mockResolvedValue({ data: { user: { username: '', password: '' } } });
      await wrapper.vm.createUser()
      const msg = { response: { data: { errors: { username: ["ユーザーネームを入力してください"], password: ['パスワードを入力してください。パスワードは6文字以上100文字以下である必要があります。'] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.username[0]).toEqual("ユーザーネームを入力してください");
      expect(error.response.data.errors.password[0]).toEqual("パスワードを入力してください。パスワードは6文字以上100文字以下である必要があります。");
    }
  });
})