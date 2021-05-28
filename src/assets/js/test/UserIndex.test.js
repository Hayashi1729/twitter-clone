import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserIndex from '../components/UserIndex.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import { setupUserList } from '../components/userKey'
jest.mock('../components/userKey')

describe(`UserIndex.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const testUser = {
      id: 1,
      username: "TestUser_1",
      password: null
    }

    setupUserList.mockReturnValue({
      users: {
        value: [
          testUser
        ]
      },
      getUser() {
        return 'hoge'
      },
      deleteUser() {
        this.users.value.pop()
      }
    })

    wrapper = shallowMount(UserIndex, {
      localVue
    })
  })

  it('render UserIndex', () => {
    expect(wrapper.html()).toContain('Listing Users')
  })

  it('deleteUser', () => {
    wrapper.vm.deleteUser(1)
    expect(wrapper.vm.userList.users.value).toEqual([])
  })
})