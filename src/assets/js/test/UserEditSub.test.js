import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserEditSub from '../vue/UserEditSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

global.window = Object.create(window);
const pathname = "/users/1/edit";
Object.defineProperty(window, 'location', {
  value: {
    pathname: pathname
  },
});

const testUser = {
  id: 1,
  username: "TestUser_1",
  password: null
}

describe(`UserEditSub.vue`, () => {
  const wrapper = shallowMount(UserEditSub, {
    provide: {
      userList: {
        users: {
          value: [
            testUser
          ]
        },
        userGet() {
          return 'hoge'
        },
        userDelete() {
          this.users.value.pop()
        }
      },
    },
    localVue
  })

  it('render UserEditSub', () => {
    expect(wrapper.html()).toContain('Edit User')
  })

  it('currentUserUsername getter', () => {
    expect(wrapper.vm.currentUserUsername).toEqual("TestUser_1")
  })

  it('currentUserUsername setter', async () => {
    const usernameInput = wrapper.find('input[type="text"]');
    await usernameInput.setValue('update username')
    wrapper.vm.currentUserUsername
    expect(wrapper.vm.userList.users.value[0].username).toEqual('update username')
  })

  it('currentUserPassword getter', () => {
    expect(wrapper.vm.currentUserPassword).toBeNull()
  })

  it('currentUserPassword setter', async () => {
    const usernameInput = wrapper.find('input[type="password"]');
    await usernameInput.setValue('password')
    wrapper.vm.currentUserPassword
    expect(wrapper.vm.userList.users.value[0].password).toEqual('password')
  })

  it('editUser', async () => {
    axios.put.mockResolvedValue({ id: 1, user: { username: 'test', password: 'password' } });
    await wrapper.vm.editUser(1)
    expect(window.location.href).toBe("/users")
  })

  it('error in editUser ', async () => {
    expect.assertions(2);
    try {
      axios.put.mockResolvedValue({ id: 1, user: { username: '', password: '' } });
      await wrapper.vm.editUser(1)
      const msg = { response: { data: { errors: { username: ["ユーザーネームを入力してください"], password: ['パスワードを入力してください。パスワードは6文字以上100文字以下である必要があります。'] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.username[0]).toEqual("ユーザーネームを入力してください");
      expect(error.response.data.errors.password[0]).toEqual("パスワードを入力してください。パスワードは6文字以上100文字以下である必要があります。");
    }
  });
})