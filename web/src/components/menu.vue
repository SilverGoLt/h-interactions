<template>
    <div v-show="display" class="flex items-center justify-end flex-1 w-full h-screen pr-56 bg-gray-500 main-dialog">
        <div class="flex flex-col items-start space-y-5 menu-main">
            <div class="text-xl text-black menu-info">
                <span>{{ data.title }}</span>
            </div>
            <div class="flex flex-col space-y-3 menu-items">
                <div v-for="item in data.items" :key="item.action" class="relative flex items-center justify-center w-40 h-12 text-black transition-all ease-in-out border-2 border-white rounded-md cursor-pointer hover:text-white item">
                    <span>{{ item.name }}</span>
                    <div v-if="item.icon" class="absolute flex items-center justify-center w-6 h-6 px-4 py-4 text-black bg-white rounded-md -left-5 icon">
                        <i :class="item.icon"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import nui from '../nui'


export default {
    name: 'Menu System',
    props: ['display', 'data'],
    data() {
        return {};
    },
    methods: {
    },
    mounted() {
    }
}
</script>

<style>
</style>