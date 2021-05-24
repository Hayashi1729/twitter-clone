import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserShowSub from '../vue/UserShowSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

const testUser = {
  id: 1,
  username: "TestUser_1",
}
describe(`UserShowSub.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/users/1";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    });

    wrapper = shallowMount(UserShowSub, {
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
  })

  it('render UserShowSub', () => {
    expect(wrapper.html()).toContain('Show User')
    expect(wrapper.html()).toContain('TestUser_1')
  })

  it('currentUser', () => {
    expect(wrapper.vm.currentUser.username).toEqual("TestUser_1")
  })
})