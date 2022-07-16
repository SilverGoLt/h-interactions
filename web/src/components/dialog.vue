<template>
    <transition name="fade">
    <div v-show="display" class="absolute z-20 flex items-end justify-center flex-1 w-full h-screen p-20 main-dialog">
        <div class="relative z-30 flex flex-col items-start w-1/2 space-y-2 dialogas">
            <div class="flex flex-row px-4 py-2 space-x-2 text-white bg-gray-700 rounded-md npc">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                </svg>
                <span> {{ data.name }} </span>
            </div>
            <div class="p-2 my-3 text-xs text-left text-white bg-white rounded-md description w-96 bg-opacity-10">
                <p>{{ data.text }}</p>
            </div>
            <div class="buttons">
                <div class="flex flex-row items-center pt-2 space-x-5 dialog-button">
                    <div v-for="value in data.buttons" :key="value.text">
                        <div @click="sendAction(data.name, value.label)" v-if="value.type === 'confirm'" class="px-4 py-2 text-sm text-gray-400 transition-all ease-in-out bg-white rounded-md cursor-pointer button bg-opacity-10 hover:bg-green-500 hover:bg-opacity-50 hover:text-white">
                            <span> {{ value.label }} </span>
                        </div>
                        <div @click="closeDialogus" v-if="value.type === 'close'" class="px-4 py-2 text-sm text-gray-400 transition-all ease-in-out bg-white rounded-md cursor-pointer button bg-opacity-10 hover:bg-red-400 hover:bg-opacity-40 hover:text-white">
                            <span> {{ value.label }} </span>
                        </div>
                         <div v-else-if="!value.type" class="px-4 py-2 text-sm text-gray-400 transition-all ease-in-out bg-white rounded-md cursor-pointer button bg-opacity-10 hover:bg-blue-400 hover:bg-opacity-40 hover:text-white">
                            <span> {{ value.label }} </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="absolute bottom-0 w-full shadow-bg -z-10 h-96 bg-gradient-to-t from-black to-transparent"></div>
    </div>
    </transition>
</template>

<script>
import nui from '../nui'

export default {
    name: "NPC Dialog",
    props: ["display", "data"],
    data() {
        return {};
    },
    methods: {
        closeDialogus() {
            this.$emit('closeDialogus', true)
            nui('closeDialog')
        },
        sendAction(name, label) {
            this.$emit('closeDialogus', true)
            nui('action', {name: name, label: label})
        }
    },
    mounted() {
        // Let's loop trough skinData and gather only necessary items
    },
};
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
