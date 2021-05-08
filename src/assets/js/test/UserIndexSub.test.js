import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserIndexSub from '../vue/UserIndexSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);


const testUser = {
  id: 1,
  username: "TestUser_1",
  inserted_at: "Test"
}
describe(`UserIndexSub.vue`, () => {
  const wrapper = shallowMount(UserIndexSub, {
    provide: {
      userList: {
        users: {
          value: [
            testUser
          ]
        }
      }
    }
  })
  console.log(this.userList)

  it('render UserIndexSub', () => {
    wrapper.vm.$nextTick(() => {
      expect(wrapper.html()).toContain('Listing Users')
      done()
    })
  })

  it('', () => {

  })
})