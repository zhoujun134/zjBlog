<template>
    <el-button color="#1890ff" style="color: white" class="zj-button"
        >
        <slot>这是一个亮晶晶的按钮</slot>
        </el-button
    >
</template>

<script>
export default {
    name: "zjButton",
};
</script>

<style scoped>
.zj-button {
    width: 100%;
    height: 40px;
}
</style>