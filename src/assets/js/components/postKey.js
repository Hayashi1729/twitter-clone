import { provide, inject } from "@vue/composition-api";
import storePost from "../stores/posts";

const PostKey = Symbol('Post')

function setupPostList() {
  provide(PostKey, storePost());
  const postList = inject(PostKey);
  if (!postList) {
    throw new Error(`postList is not provided`);
  }
  postList.getPost();

  return postList
};

export { setupPostList };