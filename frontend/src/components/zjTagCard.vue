<template>
  <zj-card :icon="['fas', 'tags']" iconColor="#db669f" title="标签">
    <div class="tag-clouds">
      <router-link
        class="tag-item"
        v-for="tag in tagClouds"
        :key="tag.id"
        :to="`/tag/${tag.id}`"
        :style="tag.style"
        >{{ tag.name }}
      </router-link>
    </div>

    <div class="tag-clouds" v-if="isShowTags">
      <router-link
        class="tag-item"
        v-for="tag in afterTagClouds"
        :key="tag.id"
        :to="`/tag/${tag.id}`"
        :style="tag.style"
        >{{ tag.name }}
      </router-link>
    </div>
  </zj-card>
</template>

<script>
import { mapState } from "@/store/map";
import { randomColorWordCloud } from "@/utils/word-cloud";
import { computed } from "@vue/runtime-core";
import { getTagCountList } from "@/api/tag";
import { ref } from "vue";

export default {
  name: "zjTagCard",
  setup() {
    let tags = ref([]);
    let isShowTags = ref(false);

    let { tagCounts } = mapState("tagAbout");

    if (tagCounts.value.length === 0) {
      getTagCountList().then((data) => {
        tags.value.push(...data);
        isShowTags.value = true;
      });
    }

    let tagClouds = computed((words, config) =>
      randomColorWordCloud(tagCounts.value, config)
    );

    let afterTagClouds = computed((words, config) =>
      randomColorWordCloud(tags.value, config)
    );
    return { tagClouds, afterTagClouds, isShowTags };
  },
};
</script>

<style scoped>
.tag-clouds {
  font-size: 14px;
  box-sizing: border-box;
}

.tag-item {
  text-decoration: none;
  display: inline-block;
  transition: all 0.4s;
  padding: 0 4px;
  overflow-wrap: break-word;
  line-height: 2;
}

.tag-item:hover {
  color: var(--theme-color) !important;
}
</style>
