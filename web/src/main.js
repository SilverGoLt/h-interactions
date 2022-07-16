import { createApp } from 'vue'
import './tailwind.css'
import App from './App.vue'

// Icons
import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"; 
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons';
import { dom } from "@fortawesome/fontawesome-svg-core";

library.add(fas)
library.add(far)
dom.watch();

const app = createApp(App)

app.mount('#app')

app.component('font-awesome-icon', FontAwesomeIcon)
