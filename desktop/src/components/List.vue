<template>
  <div id="list">
    <input v-model="keyword" placeholder="search...">
    <div ref="addButton" class="btn btn-add" @click="addItem()">
      <font-awesome-icon icon="plus"/>
    </div>
    <table>
      <thead>
      <tr>
        <th>Name</th>
        <th>URL</th>
        <th>User</th>
        <th>Key</th>
        <th>Description</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in list" :key="item.name">
        <td class="items"><input ref="nameInput" class="input-field" v-model="item.name"
                                 :disabled="!isEditing(editingItem, item.name)"></td>
        <td class="items"><input ref="urlInput" class="input-field" v-model="item.url"
                                 :disabled="!isEditing(editingItem, item.name)"></td>
        <td class="items"><input ref="userInput" class="input-field" v-model="item.user"
                                 :disabled="!isEditing(editingItem, item.name)"></td>
        <td class="items"><input ref="keyInput" class="input-field" v-model="item.key"
                                 :disabled="!isEditing(editingItem, item.name)"></td>
        <td class="items"><input ref="descInput" class="input-field" v-model="item.description"
                                 :disabled="!isEditing(editingItem, item.name)"></td>
        <td class="actions">
          <span class="btn btn-edit" @click="editItem(item.name)" :hidden="isEditing(editingItem, item.name)"><font-awesome-icon
            icon="pencil-alt"/></span>
          <span class="btn btn-confirm" @click="saveItem(item.name, item.url, item.user, item.key, item.description)"
                :hidden="!isEditing(editingItem, item.name)"><font-awesome-icon
            icon="check"/></span>
          <span class="btn btn-delete" @click="deleteItem(item.name)" :hidden="isEditing(editingItem, item.name)"><font-awesome-icon
            icon="trash-alt"/></span>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  data() {
    return {
      keyword: '',
      list: [{
        'name': 'foo',
        'url': 'example.com/dummy1',
        'user': 'dummy1',
        'key': 'key1',
        'description': 'random'
      }, {
        'name': 'bar',
        'url': 'example.com/dummy2',
        'user': 'dummy2',
        'key': 'key2',
        'description': 'random'
      }],
      editingItem: null
    }
  },

  methods: {
    addItem() {
      console.log('add button clicked')
    },

    editItem(name) {
      this.editingItem = name
    },

    isEditing(editingItem, name) {
      return editingItem === name
    },

    saveItem() {
      this.editingItem = null
    },

    deleteItem(name) {
      let index = this.list.findIndex(e => e['name'] === name)

      if (index !== -1) {
        this.list.splice(index, 1)
      }
    }
  },

  components: {
    FontAwesomeIcon
  }
}
</script>

<style scoped>
  table {
    margin: 20px;
    border-radius: 3px;
    background-color: white;
    opacity: .9;
    font-weight: 600;
    font-size: 14px;
  }

  td {
    padding: 10px;
  }

  .items {
    text-align: left;
  }

  .input-field {
    border: none;
    background-color: transparent;
  }

  .actions {
    width: 30%;
    text-align: right;
    display: inline-flex;
    justify-content: space-around;
  }

  .btn {
    cursor: pointer;
  }

  .btn-add {
    position: fixed;
    right: 10%;
    bottom: 5%;
    z-index: 1;
  }

  .btn-delete {
    margin-left: 10px;
  }
</style>
