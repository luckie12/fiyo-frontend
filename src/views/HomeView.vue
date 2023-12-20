<script setup lang="ts">
import axios from 'axios'
import {ref} from "vue";
import Modal from '../components/Modal.vue'

import { PencilIcon, CheckBadgeIcon, XCircleIcon, TrashIcon, PlusIcon } from '@heroicons/vue/24/solid'

const items = ref([])
const open = ref(false)
const openCreationModal = ref(false)
const selectedTask = ref(null)

axios.get('http://127.0.0.1:5000/todos').then((response) => {
  console.log(response.data)
  if(response.status == 200) {
    items.value = response.data
  }
})

let newTaskTitle = ""

const MarkTask = (taskId) => {
  let taskToUpdate = items.value.find(x => x.id === taskId);
  if (taskToUpdate) {
    taskToUpdate.done = !taskToUpdate.done;
  }
}

const OpenEditModal = (taskId) => {
  open.value = true
  selectedTask.value = items.value.find(x => x.id === taskId);
  newTaskTitle = selectedTask.value.body
}

const EditTask = () => {
  if(!selectedTask.value) return
  selectedTask.value.body = newTaskTitle
  open.value = false
}

const CloseModal = () => {
  open.value = false
  openCreationModal.value = false
  newTaskTitle = ""
}

const DeleteTask = (taskId) => {
  items.value.splice(items.value.findIndex(x => x.id === taskId), 1)
}

const OpenCreationModal = () => {
  openCreationModal.value = true
}

const CreateTask = () => {
  items.value = [...items.value, {
    id: items.value.length + 1,
    body: newTaskTitle,
    done: false
  }]
  CloseModal()
}

</script>

<template>
  <main>
    <div class="bg-[#1c1c1c] p-12 flex flex-col gap-2 items-center rounded-xl shadow-lg">
      <h1 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Todo App</h1>
      <button @click="OpenCreationModal" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded inline-flex items-center">
        <PlusIcon class="h-4 w-4" aria-hidden="true" />
        <span>Taak</span>
      </button>
      <ul class="w-full">
        <li v-for="item in items" class="flex justify-between mt-2">
          <div class="flex gap-2 items-center">
            <div>
              <CheckBadgeIcon class="h-4 w-4 text-green-300" aria-hidden="true"  v-if="item.done"/>
              <XCircleIcon class="h-4 w-4 text-red-300" aria-hidden="true" v-else/>
            </div>
            <div>
              {{item.body}}
            </div>
          </div>
          <div class="flex gap-2">
            <button @click="MarkTask(item.id)">
              <CheckBadgeIcon class="h-4 w-4" :class="item.done ? 'text-green-500' : 'text-gray-600'" aria-hidden="true" />
            </button>
            <button @click="OpenEditModal(item.id)">
              <PencilIcon class="h-4 w-4 text-gray-600" aria-hidden="true" />
            </button>
            <button @click="DeleteTask(item.id)">
              <TrashIcon class="h-4 w-4 text-red-500" aria-hidden="true" />
            </button>
          </div>
        </li>
      </ul>
    </div>
  </main>

  <Modal :open="open" @close="CloseModal">
    <template v-slot:title>Taak aanpassen</template>
    <template v-slot:description>Verander de titel van deze taak :-)</template>
    <template v-slot:form>
      <input type="text" name="title" id="title" v-model="newTaskTitle" class="block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" placeholder="Nieuwe titel" />
    </template>
    <template v-slot:button>
      <button
          type="button"
          class="inline-flex justify-center rounded-md border border-transparent bg-blue-100 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
          @click="EditTask"
      >
        Updaten!
      </button>
    </template>
  </Modal>

  <Modal :open="openCreationModal" @close="CloseModal">
    <template v-slot:title>Taak aanmaken</template>
    <template v-slot:description>Geef de taak een bijpassende naam :-)</template>
    <template v-slot:form>
      <input type="text" name="title" id="title" v-model="newTaskTitle" class="block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" placeholder="Nieuwe titel" />
    </template>
    <template v-slot:button>
      <button
          type="button"
          class="inline-flex justify-center rounded-md border border-transparent bg-blue-100 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
          @click="CreateTask()"
      >
        Aanmaken!
      </button>
    </template>
  </Modal>
</template>
