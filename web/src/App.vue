<template>
  <div class="flex items-center justify-center flex-1 w-full h-screen templates">
    <interaction :display="interaction.display" :data="interaction.data"></interaction>
    <npcDialog @closeDialogus="closeDialogas()" :display="dialogas.display" :data="dialogas.data"></npcDialog>
    <intMenu :display="playerMenu.display" :data="playerMenu"></intMenu>
  </div>
</template>

<script>
import npcDialog from './components/dialog.vue'
import interaction from './components/interaction.vue'
import intMenu from './components/menu.vue'

export default {
  name: 'App',
  components: {
    npcDialog,
    interaction,
    intMenu
  },
  data() {
    return {
      dialogas: {
        display: false,
        data: {
          name: 'Jason Frank',
          text: '',
          buttons: [
            {label: 'Test', type: 'confirm'},
            {label: 'Test'}
          ]
        }
      },
      interaction: {
        display: false,
        data: {
          posX: 0,
          posY: 0,
          scale: 0,
          text: '',
          secondText: ''
        }
      },
      playerMenu: {
        display: false,
        title: 'Policijos Menu',
        items: [
          {name: 'Surakinti Zaideja', action: 'handcuff', icon: 'fa-solid fa-handcuffs'},
          {name: 'Israsyti Bauda', action: 'handcuff', icon: 'fa-solid fa-clipboard'},
          {name: 'Vesti Zaideja', action: 'handcuff', icon: 'fa-solid fa-hands'},
        ]
      }
    }
  },
  mounted() {
    window.addEventListener('message', (event)=>{
      let item = event.data
      let data = item.args
      switch(item.action){
        case 'showInteraction': {
          let screenx = data.x * window.innerWidth
          let screeny = data.y * window.innerHeight
          this.interaction.data.posX = screenx
          this.interaction.data.posY = screeny
          this.interaction.data.scale = data.scale
          this.interaction.display = data.display
          this.interaction.data.text = data.text
          this.interaction.data.secondText = data.secondText
          break;
        }
        case 'dialog': {
          this.dialogas.display = true
          this.dialogas.data.text = data.text
          this.dialogas.data.name = data.name
          this.dialogas.data.buttons = data.menu
        }
      }
    })
  },
  methods: {
    closeDialogas() {
      this.dialogas.display = false
      console.log(this.dialogas.display)
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  user-select: none;
}

::-webkit-scrollbar {
    display: none;  /* Safari and Chrome */
}
</style>
