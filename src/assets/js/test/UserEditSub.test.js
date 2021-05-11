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

axios.put.mockResolvedValue({ id: 1, user: { username: 'test', password: 'password' } });

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

  it('userIndex', () => {
    expect(wrapper.vm.userIndex).toBe(0)
  })

  it('currentUserUsername', () => {
    expect(wrapper.vm.currentUserUsername).toEqual("TestUser_1")
  })

  it('currentUserPassword', () => {
    expect(wrapper.vm.currentUserPassword).toBeNull()
  })

  it('editUser', async () => {
    await wrapper.vm.editUser(1)
    expect(window.location.href).toBe("/users")
  })
})