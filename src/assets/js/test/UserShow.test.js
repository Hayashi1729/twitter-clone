import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserShow from '../components/UserShow.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import { useUserListStore } from '../components/userKey'
jest.mock('../components/userKey')

describe(`UserShow.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/users/1";
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

    useUserListStore.mockReturnValue({
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

    wrapper = shallowMount(UserShow, {
      localVue
    })
  })

  it('render UserShow', () => {
    expect(wrapper.html()).toContain('Show User')
    expect(wrapper.html()).toContain('TestUser_1')
  })

  it('currentUser', () => {
    expect(wrapper.vm.currentUser.username).toEqual("TestUser_1")
  })
})