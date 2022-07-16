<template>
    <div v-show="display" class="flex flex-col items-center justify-center flex-1 w-full h-screen p-20 main-dialog">
        <div class="absolute flex flex-col items-center px-2 py-2 space-y-3 text-black transform rounded-md icon"
            :style="{ left: data.posX + 'px', top: data.posY + 'px', scale: data.scale }">
            <div class="flex items-center justify-center w-8 h-8 bg-white rounded-md icon">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-6" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                </svg>
            </div>
            <div class="text-white text-opacity-50 text">
                <span>{{data.text}}</span>
            </div>
            <div v-if="data.secondText" class="text-white text-opacity-50 second-text text">
                <span>{{data.secondText}}</span>
            </div>
        </div>
    </div>
</template>

<script>
import nui from '../nui'


export default {
    name: 'NPC Dialog',
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
