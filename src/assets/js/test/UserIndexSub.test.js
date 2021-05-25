import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserIndexSub from '../components/UserIndexSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);


const testUser = {
  id: 1,
  username: "TestUser_1",
}
describe(`UserIndexSub.vue`, () => {
  const wrapper = shallowMount(UserIndexSub, {
    provide: {
      userList: {
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
      },
    },
    localVue
  })

  it('render UserIndexSub', () => {
    expect(wrapper.html()).toContain('Listing Users')
  })

  it('deleteUser', () => {
    wrapper.vm.deleteUser(1)
    expect(wrapper.vm.userList.users.value).toEqual([])
  })
})